# Maintenance

To onboard a new machine

```
cd homelab
cat /etc/ssh/ssh_host_ed25519_key.pub >> secrets/keys.nix
v secrets/keys.nix
v secrets/secrets.nix
```

To pull a GitHub repo

```
nix shell nixpkgs#gh
gh auth login
gh auth setup-git
git clone https://github.com/kowale/homelab
```

To update firmware

```
fwupdmgr get-devices
fwupdmgr refresh
fwupdmgr get-updates
fwupdmgr update
```

To update passwords

```
tar cf homelab.kdbx.tar homelab.kdbx
cat homelab.kdbx.tar | agenix -e homelab.kdbx.tar.age
agenix -r
```

If you commit a secret

```
nix shell nixpkgs#git-filter-repo
git grep aaaa $(git rev-list --all)
git filter-repo --replace-text <(echo 'aaaa==>bbbb')
git grep aaaa $(git rev-list --all)
git grep bbbb $(git rev-list --all)
```

