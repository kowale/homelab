{ config, pkgs, ... }:

{
    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
        openFirewall = true;
    };

    services.sshd.enable = true;
}
