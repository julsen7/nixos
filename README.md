# nixos-config

```bash
sudo mount /dev/nvmen1p2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/nvmen1p1 /mnt/boot
```

```bash
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix /mnt/nixos
sudo nixos-install --flake github:julsen7/nixos-config#laptop --no-write-lock-file
```

[nixos](https://nixos.org/manual/nixos/stable/#sec-configuration-syntax)
[https://search.nixos.org/packages](https://search.nixos.org/packages)
