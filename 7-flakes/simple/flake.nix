{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default =
      pkgs.stdenv.mkDerivation
      {
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
  };
}
