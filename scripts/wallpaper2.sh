#!/usr/bin/env bash

# 1. Konfiguration
WALLPAPER_DIR="$HOME/wallpaper"
# Pfad zu deinen Flake-Dotfiles, wo das Stylix-Hintergrundbild liegt
# Passe diesen Pfad an, falls dein Flake-Ordner anders heißt (z. B. $HOME/dotfiles)
FLAKE_DIR="$HOME/nixos"
STYLIX_TARGET="$FLAKE_DIR/wallpaper/BlackRain.jpg"

# 2. Bild-Auswahl (Entweder per Argument $1 oder über das Rofi-Menü)
if [[ -n "$1" ]]; then
    WALLPAPER_PATH="$1"
    SELECTED_NAME=$(basename "$WALLPAPER_PATH")
else
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        dunstify "Wallpaper Error" "Ordner $WALLPAPER_DIR existiert nicht!" -u critical
        exit 1
    fi

    shopt -s nullglob
    WALLPAPERS=( "$WALLPAPER_DIR"/*.{png,jpg,jpeg,webp} )
    shopt -u nullglob

    if (( ${#WALLPAPERS[@]} == 0 )); then
        dunstify "Wallpaper Error" "Ordner $WALLPAPER_DIR enthält keine Bilder!" -u critical
        exit 1
    fi

    # Generiere das Rofi-Menü mit Icons/Vorschauen
    menu_items=""
    for full_path in "${WALLPAPERS[@]}"; do
        basename=$(basename "$full_path")
        menu_items+="${basename}\0icon\x1f${full_path}\n"
    done

    SELECTED_NAME=$(echo -e "$menu_items" | rofi -dmenu -p "Hintergrund wählen")
    if [[ -n "$SELECTED_NAME" ]]; then
        WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED_NAME"
    else
        exit 0 # Abgebrochen durch ESC / Schließen von Rofi
    fi
fi

# 3. Ausführen der Änderungen
if [[ -n "$WALLPAPER_PATH" ]]; then
    
    # Live-Effekt: Hintergrund sofort mit swww ändern (keine Wartezeit)
    if command -v swww &> /dev/null; then
        awww img "$WALLPAPER_PATH" --transition-type wave --transition-fps 144
    fi

    # Benachrichtigung senden, dass der Wechsel läuft
    if [[ -n "$WAYLAND_DISPLAY" ]]; then
        dunstify "Hintergrund" "Wechsle zu $SELECTED_NAME... Systemfarben werden im Hintergrund neu generiert." -i "$WALLPAPER_PATH" -t 4000
    fi

    # Das gewählte Bild an den Ort kopieren, den Stylix einliest
    # (Überschreibt die alte BlackRain.jpg im Flake-Verzeichnis)
    cp "$WALLPAPER_PATH" "$STYLIX_TARGET"

    sudo nixos-rebuild switch --flake "$FLAKE_DIR#desktop" --quiet
fi
