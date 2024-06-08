# Homelab

Dotfiles, hosts, tools, disks, networks, secrets.
Personal monorepo to configure what can be configured.
Truly congruent, reproducible infrastructure-as-code.
Powers granted by Nix and NixOS.

## Hardware

### `five`

Old T14 (1st gen) with an i7-10510U,
32 GiB of RAM, 460 GiB of NVME.
This is my daily driver.

### `twelve`

Hoary, gnarled T480 with an i5,
touchscreen and an external battery.
Used as low-risk travel option,
previously occupied by ancient X220
(rest in peace).

### `moth`

MacBook Pro with an M1 and 16 GiB of RAM.
Backspace jams every now and then.
Planning to install Asahi on it soon.

### `pear`

Budget AMD box with an RTX 3060 (coming soon).

### `berry-tag-idx`

One of [berries] with some tag and index.
A berry may be responsible for a
single, local, long-running task, such as

- Live information display
- Temperature, humidity, CO2
- Monitor APRS with RTL-SDR
- Route wake-on-LAN packets
- Take a picture every 5 minutes
- Network storage, DNS server

[berries]: docs/berries.md

## Tools

Build and run a QEMU VM for a host.
You can do this from any Linux machine.

```
nix run .#tools.run-host-vm five
```

## Moodboard

- https://github.com/NixOS/infra
- https://github.com/wagdav/homelab
- https://github.com/Mic92/dotfiles
- https://github.com/kirelagin/infra
- https://github.com/Xe/nixos-configs
- https://github.com/ghuntley/ghuntley
- https://github.com/chayleaf/dotfiles
- https://github.com/MatthewCroughan/nixcfg
- https://github.com/headblockhead/dotfiles
- https://github.com/MostAwesomeDude/treehouse
- https://cs.tvl.fyi/depot/-/blob/users/tazjin/nixos
- https://github.com/gvolpe/nix-config
- https://github.com/RaitoBezarius/nixos-home
- https://spectrum-os.org/git/infra/tree/
- https://github.com/ngkz/dotfiles
- https://github.com/hlissner/dotfiles
- https://github.com/Lassulus/superconfig
- https://github.com/nix-community/infra
- https://github.com/NixOS/nixos-wiki-infra
- https://github.com/zimbatm/home
- https://github.com/nix-community/srvos
- https://github.com/jonascarpay/nix
- https://github.com/rnl-dei/nixrnl
- https://github.com/ifd3f/infra
- https://astrid.tech/projects/infrastructure/
- https://git.polynom.me/PapaTutuWawa/nixos-config
- https://github.com/lf-/dotfiles/

