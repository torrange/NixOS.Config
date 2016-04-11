{ config, pkgs, ... }:


{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    firefox
    chromium
    vim
    python27
    python27Packages.virtualenv
    python27Packages.pip
    docker
    docker-gc
    linphone
    stack
    git
    pciutils
    file	    
    gnumake
    gcc
    cudatoolkit
    kde4.okular

  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable unfree nvidia driver  
  services.xserver.videoDrivers = [ "nvidia" ];
  systemd.services.nvidia-control-devices = {wantedBy = [ "multi-user.target" ];serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";};

  # Enable docker virtualisation
  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  services.printing.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  users.extraUsers.tobi = {
    isNormalUser = true;
    uid = 1000;
  };

  system.stateVersion = "16.03";

}
