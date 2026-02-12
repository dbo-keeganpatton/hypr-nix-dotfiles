{ config, lib, pkgs, ... }:

# Animated SDDM login
let
  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };
in

{
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Desktop Environment Setup 

	# Bootloader Configs
	boot.loader.systemd-boot.enable         = true;
	boot.loader.efi.canTouchEfiVariables    = true;

	# Networking (Use nmcli)
	networking.hostName                     = "eyelady"; 
	networking.networkmanager.enable        = true;
	networking.firewall.enable              = true;

	# System Time Zone.
	time.timeZone                           = "America/Chicago";

	# Desktop Environment Setup 
	# services.xserver.enable = true;
	services.displayManager.sddm = {
	# Login Screen
	  enable                                = true;
	  wayland.enable                        = true; 
	  theme                                 = "sddm-astronaut-theme";
	  extraPackages = with pkgs; [
	        custom-astronaut
		kdePackages.qtmultimedia
		kdePackages.qtsvg
		kdePackages.qt5compat
	  ];

	};

	services.displayManager.defaultSession  = "hyprland";
	programs.hyprland.enable = true;
	programs.thunar.enable                  = true; 	# File manager
	services.gvfs.enable                    = true;		# Trash Bin
	services.tumbler.enable                 = true;		# Thumbnails


	# System Basics 
	services.libinput.enable                = true;		# Touchpad
	services.printing.enable                = true;		# Printing
	programs.light.enable                   = true;		# Brightness 
	services.openssh.enable                 = true;		# SSH Daemon
	powerManagement.enable                  = true;		# Power Management

	# Internet Browser
	programs.firefox.enable                 = true;

	# System Users 
	users.users.keegan = {
		isNormalUser                    = true;
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
			python3Packages.pip
			python3Packages.pynvim
			nightdiamond-cursors
			custom-astronaut
			wl-clipboard
			wf-recorder
			wireplumber
			pavucontrol
			tree-sitter
			fastfetch
			playerctl
			grimblast
			hyprpaper
			waypaper
			luarocks
			starship
			python3
			gnumake
			ripgrep
			neovim
			waybar
			lua5_1
			nodejs
			slurp
			unzip
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
		XDG_SESSION_TYPE        = "wayland";
		XDG_CURRENT_DESKTOP     = "Hyprland";
		MOZ_ENABLE_WAYLAND      = "1";
		QT_QPA_PLATFORM         = "wayland";
		SDL_VIDEODRIVER         = "wayland";
		GDK_BACKEND             = "wayland";

		# Cursor Configs
		XCURSOR_THEME           = "NightDiamond-Blue";
		XCURSOR_SIZE            = "32";
		HYPRCURSOR_SIZE         = "32";
	};

	# Sound
	security.rtkit.enable           = true;
	services.pulseaudio.enable      = false;
	services.pipewire = {
		enable                  = true;
		pulse.enable            = true;
		alsa.enable             = true;
		alsa.support32Bit       = true;
	};

	# Fonts
	fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

	# Nix Specific
	nixpkgs.config.allowUnfree      = true;
	system.stateVersion             = "25.11";

}

