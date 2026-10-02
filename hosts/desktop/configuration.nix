{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # BOOTLOADER

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NETWORKING & LOCALIZATION

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  zramSwap.enable = true;

  # HARDWARE & GRAPHICS

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:5@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = true;
        };
      };
    };
    xpadneo.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" "nvidia" ];
    xkb = {
      layout = "de";
      variant = "";
      options = "eurosign:e,caps:escape";
    };
  };

  # SERVICES & SECURITY

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    udisks2 = {
      enable = true;
      mountOnMedia = true;
      settings = {
        "udisks2.conf".defaults.encryption = "luks2";
        "WDC-WD10EZEX-60M2NA0-WD-WCC3F3SJ0698.conf".ATA.StandbyTimeout = 50;
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        theme = "sddm-astronaut";
        autoNumlock = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = false;
        user = "julsen";
      };
      defaultSession = "hyprland-uwsm";
    };
  };

  # VIRTUALISATION

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  # USER

  programs.zsh.enable = true;

  users.users.julsen = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" "video" "audio" "input" ];
    hashedPassword = "$y$j9T$n8yEDLyG5/IORRV5SPJ5I.$KEdyBgQbDYMSWWxeZYgW/NpdKltwuBk7RZU7ydNzb5.";
  };

  # PACKAGES

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # NIXOS

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "26.05";
}
