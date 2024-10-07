# Debugging

Known issues and how to debug them.

## Errors

```
Failed to start transient service unit: Unit nixos-rebuild-switch-to-configuration.service was already loaded or has a fragment file.
```

You may get above error if you stopped mid-switch.
Simply stop the blocking service like so

```
sudo systemctl stop nixos-rebuild-switch-to-configuration.service
```

## Manual steps

To create a self-signed CA certificate pair

```
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out cert.pem
```

