# Homelab

- [twelve](hosts/twelve)
- [five](hosts/five)
- [six](hosts/six)
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
nix run .#run-host-vm <host>
```

