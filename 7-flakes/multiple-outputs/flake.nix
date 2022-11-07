{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    # The default package is the same as before
    packages.${system} = {
      default = pkgs.stdenv.mkDerivation {
        src = ./rust-hello;
        name = "rust-hello-1.0";
        inherit system;
        nativeBuildInputs = [pkgs.cargo];
        buildPhase = ''
          cargo build --release
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp target/release/rust-hello $out/bin/rust-hello
          chmod +x $out
        '';
      };
      # Now there's a new package
      debug = pkgs.stdenv.mkDerivation {
        src = ./rust-hello;
        name = "rust-hello-debug-1.0";
        inherit system;
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
  };
}
