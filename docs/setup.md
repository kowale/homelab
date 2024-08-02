# Setup

```
nix shell nixpkgs#gh
gh auth login
gh auth setup-git
git clone https://github.com/kowale/homelab
cd homelab
cat /etc/ssh/ssh_host_ed25519_key.pub
v secrets/keys.nix
v secrets/secrets.nix
```

