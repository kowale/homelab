let

  keys = import ./keys.nix;
  inherit (keys) kon twelve five pear;
  everyone = kon ++ twelve ++ five ++ pear;

in

  {
    "hello.age".publicKeys = everyone;
    "kon.age".publicKeys = everyone;
    "wireless.age".publicKeys = everyone;
    "homelab.kdbx.tar.age".publicKeys = everyone;
    "binary_cache_key.age".publicKeys = pear ++ kon; # cache.pear.local:NdBzAs/wPQnM5PYbpwtyA32z+eDpQ+czQKO+IwvTbkQ=
  }
