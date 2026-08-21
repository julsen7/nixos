#!/usr/bin/env bash

WALLPAPER_DIR="${./wallpaper}"

if [[ -n "$1" ]]; then
    WALLPAPER_PATH="$1"
    SELECTED_NAME=$(basename "$WALLPAPER_PATH")
else
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        dunstify "Wallpaper Error" "Folder $WALLPAPER_DIR does not exist!" -u critical
        exit 1
    fi

    mapfile -t WALLPAPERS < <(find -L "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \))

    if (( ${#WALLPAPERS[@]} == 0 )); then
        dunstify "Wallpaper Error" "Folder $WALLPAPER_DIR does not contain any images!" -u critical
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
    cp "$WALLPAPER_PATH" "$HOME/.config/hypr/current_wallpaper"
    matugen image "$WALLPAPER_PATH" --source-color-index 0 >/dev/null 2>&1

    if [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
        dunstify "Wallpaper" "Set $SELECTED_NAME as wallpaper" -i "$WALLPAPER_PATH"
    fi
fi
