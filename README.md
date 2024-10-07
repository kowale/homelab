# Homelab

Infra, dotfiles, configs, disks, networks, secrets.
Monorepo to configure what can be configured.

## Hardware

- [five](hosts/five)
- [twelve](hosts/twelve)
- [pear](hosts/pear)
- [moth](hosts/moth)
- [berry-N-M](hosts/berry)

## Usage

To switch a running host,
navigate to homelab root,
checkout a commit and run

```
sw
```

To build and run a QEMU VM of a host,
including its graphical environment,
you may try

```
nix run .#tools.run-host-vm <host>
```

