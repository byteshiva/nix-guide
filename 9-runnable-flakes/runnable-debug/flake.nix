{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.debug = pkgs.stdenv.mkDerivation {
      src = ./rust-hello;
      name = "rust-hello-debug-1.0";
      inherit system;
      # Set so `nix run` can run this output
      meta.mainProgram = "rust-hello";
      nativeBuildInputs = [pkgs.cargo];
      buildPhase = ''
        cargo build
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp target/debug/rust-hello $out/bin/rust-hello
        chmod +x $out
      '';
    };
  };
}
