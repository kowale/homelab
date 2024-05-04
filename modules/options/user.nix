{ lib, pkgs, config, ... }:

let

  cfg = config.user;

in {

  options.user.name = lib.mkOption {
    type = with lib.types; nullOr str;
    default = "kon";
    example = "kon";
    description = lib.mkDoc ''
      Username of the main user.
    '';
  };

}
