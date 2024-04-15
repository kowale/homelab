{
  security.sudo = {
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  users.users.kon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    password = "kon";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCajbbzjCQqYvlkz81Hyg5FdmV1xsKCCHn7HQPGhu0nZ1JfIXkxrvmxmQwlZPyuR5dwoLqcYmhA0e2dCywNznAnRQpE8VdcosIE+OY/t6ox/NL4/u7A84lGFRwWDG9EOJ9RR4x6by77Ua/Kw7E9Jq9doym3PlHDATs+cZXTMROEv9Y4sN6HWplSz/cNL/F0CvHKi08Q6j+/vMj7CNdIUfawOpDjj56eQ7ZFDnhtzDz4NZiY8MxwUQ+bBlZS4rZs6ykef6I1xoYwUPaO2XPLYoAUEy/Y74X9UxFnZ35Wt95ja2mw6oi4DB7fIxCa+1GGB4Nx4hqxbJW4oHRQ2LoQmKNxZR5TZ7Urm0oEzFhYqjR56+2cKTm2XEE12TAfpB0l5kjYUFZzcKtgXfmoQGNXKh5tsnrCk1UE7cvuSf9X0K3MWY70x8vr0I+LubfnMYlIP3/QkJcxDd4UTp6p0rN3nAe9DYG7tBP2eCqbSR4iz4Tz0PvUNHqewviiY1sKNY8tb0="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI/ZAGUGLVmv8Y3j5/w9HqcvMX5kmIfnI1oaFDsopgL"
    ];
  };
}
