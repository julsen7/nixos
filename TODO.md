# TODO

## BUGS & FEATURES

- prism launcher: profile (+ image)
- sddm (look and autologin without keyring)
- QuickShell (dunst, snappy-switcher)

## MISSING PACKAGES

- git clone <https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module>
- cd "acer-predator-turbo-and-rgb-keyboard-linux-module"
- chmod +x ./*.sh
- sudo ./install.sh
- ./facer_rgb.py -m 3

# KI-Prompt

I want to use NixOS as my default operating system, I am very deep into it and want to fully customize and personalize it by for example coding my own quickshell. I already have a working repository but I think there are issues or just something i could do a better way or something that is duplicated dprecated or not best practice. For this I will give you my setup requirements and you will give the code so I can check if my existing aproach matches your way. I only want you to give best practice code snippets (I know that is not always quite possible due to the active maintainance and shift in the community of NixOS, but try your best). Okay, lets start: I have two laptops, the first one is my pc for home. It has an integraded AMD gpu and a second Nvidia rtx 3060 laptop gpu, my cpu is a ryzen 7 5800h (with radeon graphics). I want to game, stream and code on it (i am a computer science student). I want: networkmanager is standard i think (wifi/lan),, bluetooth, audio (i think pipewire is best), ofcourse a firewall (ufw  prbably). As bootloader i want systemd-boot and i want to use sddm and hyprland on wayland. there is only one user account, I am located in germany. openssh would be useful too but i dont really understand "rtkit or "polkit" unter security section. i want steam to play my games (with xbox controller) and i want obs for streaming and recording. i also want a virtual windows 11 mashine (i thing qemu with virt-manager) and home manager for configuration. I also want lmms, davinci resolve, thunar, kitty, easyeffects, pinta, krita, prism launcher, discord and spotify (i thing spicetify for themes). my browser should be zen. My cursor should be the "Bibata-Modern-Ice" and my font should be "JetBrainsMono Nerd Font" systemwide. i also want darkmode systemwide. 