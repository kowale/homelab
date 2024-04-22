let

  keys = import ./keys.nix;
  inherit (keys) kon twelve five;
  everyone = kon ++ twelve ++ five;

in

  {
    "hello.age".publicKeys = everyone;
    "wireless.age".publicKeys = everyone;
    "homelab.kdbx.tar.age".publicKeys = everyone;
    "kon.age".publicKeys = everyone;
    "twelve_binary_cache_key.age".publicKeys = everyone;
  }
