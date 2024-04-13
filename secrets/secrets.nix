let

  kon = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI/ZAGUGLVmv8Y3j5/w9HqcvMX5kmIfnI1oaFDsopgL kon@tkon"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5fpblXJJz86UhhpLL+1nqlmyLAPK/rc4VQ1MczqyRU kon@twelve"
  ];

  twelve = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe0bcbQNBb4qZBn5nAsE0vLFGTK+zdAiHhgT3S0GcmA"
  ];

  tkon = [
    # TODO
  ];

in

  {
    "hello.age".publicKeys = kon ++ twelve;
    "wireless.age".publicKeys = kon ++ twelve;
    "homelab.kdbx.age".publicKeys = kon ++ twelve;
  }