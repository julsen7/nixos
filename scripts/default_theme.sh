#!/usr/bin/env bash

COLORFUL_THEME_DIR="$HOME/themes/colorful"

DUNST_TARGET="$HOME/.config/dunst/dunstrc"
HYPR_LUA_TARGET="$HOME/.config/hypr/colors.lua"
HYPR_CONF_TARGET="$HOME/.config/hypr/colors.conf"
KITTY_TARGET="$HOME/.config/kitty/current-theme.conf"
ROFI_TARGET="$HOME/.config/rofi/colors.rasi"
WAYBAR_TARGET="$HOME/.config/waybar/colors.css"

ln -sf "$COLORFUL_THEME_DIR/dunstrc" "$DUNST_TARGET"
ln -sf "$COLORFUL_THEME_DIR/hypr.lua" "$HYPR_LUA_TARGET"
ln -sf "$COLORFUL_THEME_DIR/hypr.conf" "$HYPR_CONF_TARGET"
ln -sf "$COLORFUL_THEME_DIR/kitty.conf" "$KITTY_TARGET"
ln -sf "$COLORFUL_THEME_DIR/rofi.rasi" "$ROFI_TARGET"
ln -sf "$COLORFUL_THEME_DIR/waybar.css" "$WAYBAR_TARGET"