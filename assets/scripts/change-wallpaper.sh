#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpaper"

if [[ -n "$1" ]]; then
    WALLPAPER_PATH="$1"
    SELECTED_NAME=$(basename "$WALLPAPER_PATH")
else
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        if command -v dunstify &>/dev/null; then
            dunstify "Wallpaper Error" "Folder $WALLPAPER_DIR does not exist!" -u critical
        fi
        exit 1
    fi

    mapfile -t WALLPAPERS < <(find -L "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \))

    if (( ${#WALLPAPERS[@]} == 0 )); then
        if command -v dunstify &>/dev/null; then
            dunstify "Wallpaper Error" "Folder $WALLPAPER_DIR does not contain any images!" -u critical
        fi
        exit 1
    fi

    menu_items=""
    for full_path in "${WALLPAPERS[@]}"; do
        basename=$(basename "$full_path")
        menu_items+="${basename}\0icon\x1f${full_path}\n"
    done
 
    SELECTED_NAME=$(echo -e "$menu_items" | rofi -dmenu)
    if [[ -n "$SELECTED_NAME" ]]; then
        for full_path in "${WALLPAPERS[@]}"; do
            if [[ "$(basename "$full_path")" == "$SELECTED_NAME" ]]; then
                WALLPAPER_PATH="$full_path"
                break
            fi
        done
    else
        exit 0
    fi
fi

if [[ -n "$WALLPAPER_PATH" ]]; then
    mkdir -p "$HOME/.config/hypr"
    cp "$WALLPAPER_PATH" "$HOME/.config/hypr/current_wallpaper"
    matugen image "$WALLPAPER_PATH" --source-color-index 0 >/dev/null 2>&1

    ln -sf "$HOME/.config/theme/dunstrc" "$HOME/.config/dunst/dunstrc"
    ln -sf "$HOME/.config/theme/hypr.lua" "$HOME/.config/hypr/colors.lua"
    ln -sf "$HOME/.config/theme/hypr.conf" "$HOME/.config/hypr/colors.conf"
    ln -sf "$HOME/.config/theme/kitty.conf" "$HOME/.config/kitty/current-theme.conf"
    ln -sf "$HOME/.config/theme/rofi.rasi" "$HOME/.config/rofi/colors.rasi"
    ln -sf "$HOME/.config/theme/waybar.css" "$HOME/.config/waybar/colors.css"

    if [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]] && command -v dunstify &>/dev/null; then
        dunstify "Wallpaper" "Set $SELECTED_NAME as wallpaper" -i "$WALLPAPER_PATH"
    fi
fi
