let

  keys = import ./keys.nix;
  inherit (keys) kon pear twelve five six;
  everyone = kon ++ pear ++ twelve ++ five ++ six;

in

  {
    "hello.age".publicKeys = everyone;
    "kon.age".publicKeys = everyone;
    "wireless.age".publicKeys = everyone;
    "netrc.age".publicKeys = everyone;
    "homelab.kdbx.tar.age".publicKeys = everyone;
    "binary_cache_key.age".publicKeys = pear ++ kon;
    "restic/env.age".publicKeys = everyone;
    "restic/repo.age".publicKeys = everyone;
    "restic/password.age".publicKeys = everyone;
  }
