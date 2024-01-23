# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
imports = [
	# Import Hardware-configs
	./hardware-configuration.nix

];

# Enable Flakes 
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Bootloader.
  	boot.loader.systemd-boot.enable = true;
  	boot.loader.efi.canTouchEfiVariables = true;

  	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "Asia/Almaty";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

# Configure keymap in X11
services.xserver = {
	layout = "us,ru";
	xkbVariant = "workman,";
	xkbOptions = "grp:alt_shift_toggle";
		};

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.aibarchok = {
	isNormalUser = true;
	description = "aibarchok";
	extraGroups = [ "networkmanager" "wheel" ];
	packages = with pkgs; [];
  };

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
#environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#  wget
#];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
	networking.firewall = {
		allowedTCPPorts = [ ];
	      	allowedUDPPorts = [ ];
	      	enable = true;
};
	networking.nftables.enable = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?

# Enable Doas
	security.doas.enable = true;
	security.sudo.enable = false;
	security.doas.extraRules = [{
    		users = ["aibarchok"];
    		keepEnv = true;
    		persist = true;
    	}];
# Enable Hyprland
programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	#xwayland.hidpi = true;
	enableNvidiaPatches = true;
	};   


# Enable Pipewire sound system
	security.rtkit.enable = true;
	services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	wireplumber.enable = true;
	};

# Enable ZSH
	programs.zsh.enable = true;

# Shell Options
	users.users.aibarchok.shell = pkgs.zsh;

# Enable Steam
programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	};

# Enable Gamescope for Steam
	programs.steam.gamescopeSession.enable = true;

# Enable OpenGL
hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
  	};

# Enable CUPS for printing
	services.printing.enable = true;

# Load Nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = ["nvidia"];

# Load Nvidia-Prime driver (optional)
hardware.nvidia.prime = {
# Make sure to use the correct Bus ID values for your system!
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
};

# Software
environment.systemPackages = with pkgs; [ 
	zsh
	gcc
	gnumake
	wget
	curl
	tcpdump
	neovim
	nmap
	rsync
	dnsutils
	netcat
   	doas
   	wget
	tree
	gnome.gnome-keyring
	glibc
	git
	gnupg
	curl
	unzip
	dunst
	mpv
	lshw
	killall
	libvirt
	neofetch
	htop
	ranger
	newsboat

   	firefox-wayland
   	librewolf-wayland
	libreoffice
   	dino
   	telegram-desktop
   	protontricks
   	gimp
	kdenlive
	audacity
   	keepassxc
	syncthing

	wineWowPackages.stable
	winetricks
	wineWowPackages.waylandFull

	hyprland
	hyprpaper
	hyprpicker
	eww-wayland
   	waybar
   	swaylock
   	wofi
	wayshot
	alacritty
	xwayland

	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	xdg-utils

	ydotool
	lxappearance

  ];

fonts.packages = with pkgs; [
	dejavu_fonts
	google-fonts
	nerdfonts
   	jetbrains-mono
   	hack-font
   	font-awesome
   	roboto-mono
   	noto-fonts
   	liberation_ttf
  ];

  services.dbus.enable = true;
  xdg.portal = {
  	enable = true;
	extraPortals = [pkgs.xdg-desktop-portal-gtk];
};

# Environment's etc
environment.etc = {
	"xdg/gtk-3.0" .source = ./gtk-3.0;
};

# Environment variables
environment = {
variables = {
	QT_QPA_PLATFORMTHEME = "qt5ct";
	QT_QPA_PLATFORM = "xcb obs";
   };
};

# Enable Touchpad support
	services.xserver.libinput.enable = true;



}
