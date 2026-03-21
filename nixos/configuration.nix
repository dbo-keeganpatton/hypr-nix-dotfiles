{ config, lib, pkgs, ... }:

let

  # Custom SDDM login Screen with animated anime girl
  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };


  # Latest Neovim Overlay for 0.12 support
  neovim-nightly-overlay = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  });

  # This block is to support a pop up window for my active keybinds
  # as a helper tool using SUPER+i 
  keybind-helper = pkgs.writeShellScriptBin "keybind-helper" ''
    CONFIG_PATH="$HOME/.config/hypr/hyprland.conf"
    grep '^bind =' "$CONFIG_PATH" | \
        sed -e 's/\$mainMod/SUPER/g' \
            -e 's/^bind[a-z]*\s*=\s*//g' \
            -e 's/,/  +  /g' \
            -e 's/,/  :  /g' | \
        ${pkgs.rofi}/bin/rofi -dmenu -i -p "󱕰 Keybinds" 
  '';
  
in

{
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

  # Bluetooth Config
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable                         = true;


  # FlatPak
  services.flatpak.enable                         = true;

  # Enable 32bit support for steam to work
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };

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
      python3Packages.pynvim        # Neovim Python Client 
      python3Packages.pip           # Python Package Manager
      custom-astronaut              # SDDM Login Screen
      phinger-cursors               # Custom Cursor
      keybind-helper                # Custom function for keybind ref popup utility
      wl-clipboard                  # Wayland Copy/Paste Utility
      wf-recorder                   # Screen Recording Utility
      wireplumber                   # Audio Utility
      alsa-utils                    # Audio Utility
      pavucontrol                   # Audio Control GUI
      tree-sitter                   # Syntax Parser for Editor
      fastfetch                     # System Info Tool
      playerctl                     # Audio Utility
      grimblast                     # Screenshots
      hyprpaper                     # Wallpaper Utility
      hyprlock                      # Screen Locking
      hypridle                      # System Idle Daemon 
      waypaper                      # Wallpaper Manager
      luarocks                      # Lua Package Manager
      starship                      # Command Line Prompt Customizer
      python3                       # Python Runtime
      zathura                       # Terminal Based PDF Utility
      gnumake                       # Build Automation for MAKE
      ripgrep                       # System Search Tool
      neovim                        # Text Editor
      heroku                        # Deployment and Hosting Service CLI
      kalker                        # System Calculator
      waybar                        # Desktop Navbar
      lua5_1                        # Lua Runtime
      nodejs                        # Node Package Manager
      steam                         # Video Games
      slurp                         # Screenshot helper utility
      unzip                         # Extraction Utility
      rustc                         # Rust runtime
      cargo                         # Rust Package Manager
      krita                         # Vector grapgic editor
      rofi                          # Wayland Window Switcher Utility
      foot                          # Wayland Native Terminal Emulator
      kitty                         # I shouldn't even have this shit here, literally just for pets.nvim
      wofi                          # Menu GUI
      btop                          # System Process Management
      yazi                          # Command Line File Manager
      grim                          # Screenshot Utility
      tmux                          # Terminal Multiplexer
      wget                          # File downloader
      gcc                           # C Compiler
      fzf                           # Command Line Fuzzy Finder
      git                           # Version Control Tool
      bun                           # Javascript runtime
      fd                            # Alternative to Find Utility
      jq                            # CLI JSON Processor
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
		XCURSOR_SIZE                        = "24";
		HYPRCURSOR_SIZE                     = "24";
	};

  # Sound
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  hardware.enableAllFirmware = true;

  # This directory has to be manually made to save default
  # for alsactl
  systemd.tmpfiles.rules = [
    "d /var/lib/alsa 0755 root root -"
  ];

  boot.extraModprobeConfig = ''
    options snd_hda_intel index=0 model=auto
    options snd_rn_pci_acp3x index=-2
  '';

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig."10-fix-ryzen-audio" = {
        "monitor.alsa.rules" = [
          {
            # Kill the HDMI card
            matches = [ { "device.name" = "~alsa_card.pci-0000_03_00.1"; } ];
            actions = { update-props = { "device.disabled" = true; }; };
          }
          {
            # Configure the Hardware Profile
            matches = [ { "device.name" = "~alsa_card.pci-0000_03_00.6"; } ];
            actions = {
              update-props = {
                "api.alsa.use-acp" = true;
                "device.profile-set" = "default.conf";
                "device.profile" = "analog-stereo";
                "api.acp.auto-profile" = false;
                "api.acp.auto-port" = false;
              };
            };
          }
          {
            # Configure the Output Volume/Mute
            matches = [ { "node.name" = "~alsa_output.pci-0000_03_00.6.*"; } ];
            actions = {
              update-props = {
                "node.description" = "Laptop Speakers";
                "node.mute" = false;
                "node.volume" = 0.6; 
              };
            };
          }
        ];
      };
    };
  };

  # This ensures ALSA settings are preserved across reboots
  # Helps with Alsa/Pipewire defaulting to read from HDMI
  systemd.services.alsa-store = {
    description = "Store ALSA Subsystem State";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/true";
      ExecStop = "${pkgs.alsa-utils}/sbin/alsactl store";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

