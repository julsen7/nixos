{ config, pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  # GENERAL

  home.username = "julsen";
  home.homeDirectory = "/home/julsen";
  home.stateVersion = "26.05";

  # THEMING & CURSOR

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Sans";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/shell/extensions/just-perfection" = {
      app-menu = false;
      activities-button = false;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  fonts = {

    packages = with pkgs; [
      pkgs.nerd-fonts.ubuntu
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "pkgs.nerd-fonts.ubuntu-mono" ];
        sansSerif = [ "pkgs.nerd-fonts.ubuntu-sans" ];
        serif = [ "pkgs.nerd-fonts.ubuntu" ];
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  # PACKAGES

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    thunar
    discord
    pinta
    krita
    davinci-resolve
    easyeffects
    prismlauncher
    heroic
    libreoffice-stable
    audacity
    lmms

    btop
    _7zz
    github-cli

    hyprpolkitagent
    brightnessctl
    hyprpicker
    hyprshot
    matugen
    cliphist
    wl-clipboard
    playerctl
    libnotify
    bluetui
    wiremix
    nvtopPackages.full
  ];

  # SYSTEM
  xdg.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  home.sessionVariables = {
    EDITOR = "codium";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/share/icons"
    "${config.home.homeDirectory}/.spicetify"
  ];

  home.file = {
    "wallpaper".source = ./wallpaper;
  };

  # FILES & CONFIGURATION

  xdg.configFile = {
    "quickshell".source = ./assets/quickshell;
    "matugen".source = ./assets/matugen;
    "obs-studio/basic".source = ./assets/obs-studio/basic;
    "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };

  # PROGRAMS

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      ignoreAllDups = true;
      saveNoDups = true;
      size = 10000;
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first --color=always";
      ll = "eza -lh --icons --group-directories-first";
      lt = "eza --tree --level=2 --icons";
      la = "eza -a --icons";
      lla = "eza -lha --icons --group-directories-first";
      cd = "z";
      cl = "clear";
    };

    completionInit = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.cache/zsh/
      autoload -U compinit && compinit
    '';

     oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };

    initContent = ''
      bindkey '^[[3~' delete-char
      fastfetch
    '';
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      alias = {
        co = "checkout";
        st = "status";
      };
      user = {
        name  = "julsen7";
        email = "263753131+julsen7@users.noreply.github.com";
      };
      "credential \"https://github.com\"" = {
          helper = "${pkgs.github-cli}/bin/gh auth git-credential";
      };
      "credential \"https://gist.github.com\"" = {
          helper = "${pkgs.github-cli}/bin/gh auth git-credential";
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
      };
      display = {
        separator = " ";
      };
      modules = [
        "title"
        {
          type = "os";
          key = "os    ";
          keyColor = "33";
        }
        {
          type = "host";
          format = "{5} {1}";
          key = "host  ";
          keyColor = "33";
        }
        {
          type = "packages";
          format = "{}";
          key = "pkgs  ";
          keyColor = "33";
        }
        {
          type = "uptime";
          format = "{2}h {3}m";
          key = "uptime";
          keyColor = "33";
        }
        {
          type = "memory";
          key = "memory";
          keyColor = "33";
        }
        "break"
        {
          type = "colors";
          block = {
            range = [ 0 7 ];
          };
          keyColor = "33";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    
    extraConfig = ''
      local success, colors = pcall(require, "colors")

      if not success then
        colors = {
          primary_container = "0xee1a1a1a"
        }
      end

      -- =========================================================================
      -- Monitor-Setups
      -- =========================================================================

      hl.monitor({
        output   = "HDMI-A-1",
        mode     = "2560x1440@144",
        position = "1920x500",
        scale    = 1,
      })

      hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1080@144",
        position = "0x0",
        scale    = 1,
      })

      -- Fallback for extern monitors
      hl.monitor({
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = 1,
      })

      -- =========================================================================
      -- Workspaces
      -- =========================================================================

      for i = 1, 3 do
        hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", persistent = true })
      end

      for i = 4, 6 do
        hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", persistent = true })
      end

      -- =========================================================================
      -- Autostart / Startup Events
      -- =========================================================================

      hl.on("hyprland.start", function()
        -- Clipboard & Daemons
        hl.exec_cmd("uwsm app -- udiskie")
        hl.exec_cmd("uwsm app -- quickshell -p /home/julsen/.config/quickshell")

        -- Apps
        hl.exec_cmd("uwsm app -- discord --start-minimized")
        hl.exec_cmd("uwsm app -- spotify", { workspace = "6 silent" })

        -- Fokus auf Workspace 1
        -- hl.dispatch(hl.dsp.focus({ workspace = "4" }))

        -- Default monitor
        -- hl.exec_cmd("xrandr --output HDMI-A-1 --primary")
      end)

      -- =========================================================================
      -- General configuration
      -- =========================================================================

      hl.config({
        general = {
          border_size      = 0,
          gaps_in          = 5,
          gaps_out         = 10,
          resize_on_border = true,
        },
        decoration = {
          rounding = 20,
          shadow   = {
            enabled = true,
            range   = 10,
            color   = "rgba(000000ee)",
          },
        },
        input = {
          kb_layout = "de",
        },
      })

      -- =========================================================================
      -- Keybindings
      -- =========================================================================

      -- System & Fenstersteuerung
      hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
      hl.bind("ALT + F4", hl.dsp.window.close())
      hl.bind("F11", hl.dsp.window.fullscreen())
      hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
      hl.bind("SUPER + S", hl.dsp.layout("togglesplit"))

      -- Navigation & Drag/Resize
      hl.bind("SUPER + up", hl.dsp.window.move({ direction = "up" }))
      hl.bind("SUPER + down", hl.dsp.window.move({ direction = "down" }))
      hl.bind("SUPER + right", hl.dsp.window.move({ direction = "right" }))
      hl.bind("SUPER + left", hl.dsp.window.move({ direction = "left" }))
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- App-Launcher & Quick-Tools
      -- hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("uwsm app -- kitty --title=wiremix -e wiremix"))

      hl.bind("SUPER + ALT", hl.dsp.global("quickshell:menu"))
      hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("uwsm app -- hyprshot -m region --clipboard-only"))
      hl.bind("SUPER + P", hl.dsp.exec_cmd("uwsm app -- hyprpicker -a"))

      -- Quickstart-Shortcuts
      hl.bind("SUPER + Q", hl.dsp.exec_cmd("uwsm app -- kitty"))
      hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- thunar"))
      hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm app -- zen"))
      hl.bind("SUPER + M", hl.dsp.exec_cmd("uwsm app -- spotify"))
      hl.bind("SUPER + D", hl.dsp.exec_cmd("uwsm app -- discord"))
      hl.bind("SUPER + C", hl.dsp.exec_cmd("uwsm app -- codium"))

      -- Workspaces 1-6
      for i = 1, 6 do
        hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
      end

      hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

      -- Gestures
      hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

      -- Multimedia & Hardware-Tasten
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

      -- =========================================================================
      -- Animations
      -- =========================================================================

      hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0 }, { 0.35, 1 } } })
      hl.curve("rubber", { type = "spring", mass = 1, stiffness = 40, dampening = 10 })

      hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "easeInOutCubic", style = "slide" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 2, spring = "rubber", style = "slide" })
    '';
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      color0 = "#100a19";
      color1 = "#4E6468";
      color2 = "#458A78";
      color3 = "#4F7985";
      color4 = "#33908F";
      color5 = "#3DA19C";
      color6 = "#51A192";
      color7 = "#c3c1c5";

      window_margin_width = "10 15";
      window_resize_step_cells = 5;
      window_resize_step_lines = 2;
      confirm_os_window_close = 0;

      background_opacity = "0.9";
      background_blur = 0;

      disable_ligatures = "never";

      cursor_stop_blinking_after = 0;
      cursor_trail = 10;

      mouse_hide_wait = "3.0";
      
      enable_audio_bell = false;
      force_ltr = false;
      detect_urls = true;

      window_padding_width = 30;

      shell = "zsh";
    };

    extraConfig = ''
      include current-theme.conf
    '';
  };

  programs.obs-studio = {
    enable = true;

    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
    theme = spicePkgs.themes.sleek;
    colorScheme = "UltraBlack";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    presets = [ "no-runtime-versions" ];

    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$os"
        "$directory"
        "$git_branch"
        "$git_status"
        "$fill"
        "$all"
        "$cmd_duration"
        "$time"
        "$line_break"
        "$character"
      ];

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      os = {
        format = "[$symbol]($style) ";
        disabled = false;
        symbols = {
          NixOS = "";
        };
      };
      directory = {
        format = "[󰉋 $path]($style)[$read_only]($read_only_style) ";
        truncate_to_repo = false;
        substitutions = {
          "Documents" = "󰈙 Documents";
          "Downloads" = " Downloads";
          "Music" = " Music";
          "Pictures" = " Pictures";
        };
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
      };
      fill = {
        symbol = "·";
        style = "white";
      };
      maven = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "";
        style = "#c31e3d";
      };
      gradle = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "";
        style = "#02303a";
      };
      java = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󰬷";
        style = "#ed8b00";
      };
      c = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󰙱";
        style = "#3848a9";
      };
      cpp = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󰙲";
        style = "#00599c";
      };
      haskell = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󰲒";
        style = "#5e5086";
      };
      kotlin = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󱈙";
      };
      python = {
        format = " [\${symbol} (\${version})]($style) ";
        symbol = "󰌠";
        style = "#ffd43b";
      };
      cmd_duration = {
        format = " 󱦟 [$duration]($style) ";
      };
      time = {
        disabled = false;
        format = "  [$time]($style) ";
      };
    };
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.thunar}/bin/thunar";
        terminal = "${pkgs.kitty}/bin/kitty";
        tray = true;
        udisks_version = 2;
      };
      icon_names = {
        media = [ "media-optical" ];
      };
    };
  };

  programs.vscodium = {
    enable = true;
    profiles.default = {
      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font Propo";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;
        "files.autoSave" = "afterDelay";
        "files.exclude" = {
          "**/.git" = false;
        };
        "files.simpleDialog.enable" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "workbench.colorTheme" = "GitHub Dark Default";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "workbench.startupEditor" = "none";
      };
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
        bbenoist.nix
        davidanson.vscode-markdownlint
        eamodio.gitlens
        github.github-vscode-theme
      ];
    };
  };
}
