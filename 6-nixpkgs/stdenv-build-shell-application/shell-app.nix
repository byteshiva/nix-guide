let pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/0b20bf89e0035b6d62ad58f9db8fdbc99c2b01e8.tar.gz") {};
in pkgs.writeShellApplication {
  name = "hello";

  text = ''
    echo Hello World
  '';
}

