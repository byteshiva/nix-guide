{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      # A list of shell names and their Python versions
      pythonVersions = {
        python38 = pkgs.python38;
        python39 = pkgs.python39;
        python310 = pkgs.python310;
        default = pkgs.python310;
      };
      # A function to make a shell with a python version
      makePythonShell = shellName: pythonPackage: pkgs.mkShell {
        packages = [ pythonPackage ];
      };
    in
    {
      devShells.x86_64-linux = builtins.mapAttrs makePythonShell pythonVersions;
    };
}
