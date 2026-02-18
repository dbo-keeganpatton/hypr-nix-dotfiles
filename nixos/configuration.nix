{ config, lib, pkgs, ... }:

# Custom Vars
let

  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };

  neovim-nightly-overlay = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  });

in

{
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Bootloader Configs
	boot.loader.systemd-boot.enable                 = true;
	boot.loader.efi.canTouchEfiVariables            = true;

	# Networking (Use nmcli)
	networking.hostName                             = "eyelady"; 
	networking.networkmanager.enable                = true;
	networking.firewall.enable                      = true;

	# System Time Zone.
	time.timeZone                                   = "America/Chicago";

	# Desktop Environment Setup 
	services.displayManager.sddm = {
	# Login Screen
	  enable                                        = true;
	  wayland.enable                                = true; 
	  theme                                         = "sddm-astronaut-theme";
	  extraPackages = with pkgs; [
	        custom-astronaut
		kdePackages.qtmultimedia
		kdePackages.qtsvg
		kdePackages.qt5compat
	  ];

	};

	services.displayManager.defaultSession          = "hyprland";
	programs.hyprland.enable                        = true;
	programs.thunar.enable                          = true; 	# File manager
	services.gvfs.enable                            = true;		# Trash Bin
	services.tumbler.enable                         = true;		# Thumbnails

  # This is for auto locking the screen
  services.logind.settings.Login.HandleLidSwitch  = "suspend"; 
  programs.hyprlock.enable                        = true;
  services.hypridle.enable                        = true;
  services.dbus.enable                            = true;
  security.polkit.enable                          = true;


	# System Basics 
	services.libinput.enable                        = true;		# Touchpad
	services.printing.enable                        = true;		# Printing
	programs.light.enable                           = true;		# Brightness 
	services.openssh.enable                         = true;		# SSH Daemon
	powerManagement.enable                          = true;		# Power Management

	# Internet Browser
	programs.firefox.enable                         = true;

	# System Users 
	users.users.keegan = {
		isNormalUser                                  = true;
		extraGroups = [ 
			"networkmanager"
			"video"
			"audio"
			"wheel" 
			"sudo" 
		];
		packages = with pkgs; [

			];
	};


	# System Packages
	# https://search.nixos.org/ 
	environment.systemPackages = with pkgs; [
			python3Packages.pynvim
			python3Packages.pip
			custom-astronaut
      phinger-cursors
			wl-clipboard
			wf-recorder
			wireplumber
			alsa-utils
			pavucontrol
			tree-sitter
			fastfetch
			playerctl
			grimblast
			hyprpaper
      hyprlock
      hypridle
			waypaper
			luarocks
			starship
			python3
      zathura
			gnumake
			ripgrep
			neovim
			waybar
			lua5_1
			nodejs
			slurp
			unzip
      rustc
      cargo
			foot
			wofi
			btop
			grim
			tmux
			wget
			gcc
			fzf
			git
			fd
		];

	# Wayland Variables
	environment.sessionVariables = {
		XDG_SESSION_TYPE                    = "wayland";
		XDG_CURRENT_DESKTOP                 = "Hyprland";
		MOZ_ENABLE_WAYLAND                  = "1";
		QT_QPA_PLATFORM                     = "wayland";
		SDL_VIDEODRIVER                     = "wayland";
		GDK_BACKEND                         = "wayland";

		# Cursor Configs
		XCURSOR_THEME                       = "phinger-cursors-light";
		XCURSOR_SIZE                        = "32";
		HYPRCURSOR_SIZE                     = "32";
	};

        # Sound
        security.rtkit.enable           = true;
        services.pulseaudio.enable      = false;
        services.pipewire = {
                enable                  = true;
                alsa.enable             = true;
                alsa.support32Bit       = true;
                pulse.enable            = true;
                wireplumber.enable      = true; 
        };
        xdg.portal = {
                enable                  = true;
		            extraPortals            = [pkgs.xdg-desktop-portal-gtk];
	};


	# Fonts
	fonts.packages                        = [ pkgs.nerd-fonts.jetbrains-mono ];

	# Nix Specific
	nixpkgs.config.allowUnfree            = true;

  # Neovim Nightly Conig
  nixpkgs.overlays                      = [ neovim-nightly-overlay ];
  programs.neovim = {
    enable                              = true;
    package                             = pkgs.neovim;
  };

	system.stateVersion                   = "25.11";

}

