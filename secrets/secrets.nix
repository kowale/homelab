let

  keys = import ./keys.nix;
  inherit (keys) kon twelve five;

in

  {
    "hello.age".publicKeys = kon ++ twelve ++ five;
    "wireless.age".publicKeys = kon ++ twelve ++ five;
    "homelab.kdbx.tar.age".publicKeys = kon ++ twelve ++ five;
  }
