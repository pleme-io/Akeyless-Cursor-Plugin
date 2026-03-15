{
  description = "VS Code / Cursor extension for managing Akeyless secrets and scanning for hardcoded secrets";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.default = pkgs.buildNpmPackage {
        pname = "akeyless-secrets-manager";
        version = "0.0.0-dev";
        src = self;
        npmDepsHash = "sha256-+lxFRxM4ZzaJGkTKK/LPSnM5hBLVwldWzxo5Ix9FgRU="; # TODO: set correct hash
        dontNpmBuild = false;
        npmBuildScript = "compile";
        meta = {
          description = "VS Code / Cursor extension for managing Akeyless secrets and scanning for hardcoded secrets";
          homepage = "https://github.com/pleme-io/Akeyless-Cursor-Plugin";
          license = pkgs.lib.licenses.mit;
        };
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [ nodejs_22 ];
      };
    });
}
