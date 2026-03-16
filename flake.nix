{
  description = "VS Code / Cursor extension for managing Akeyless secrets and scanning for hardcoded secrets";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pleme-linker = {
      url = "github:pleme-io/pleme-linker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, substrate, pleme-linker }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      substrateLib = substrate.libFor {
        inherit pkgs system;
      };

      plemeLinkerPkg = pleme-linker.packages.${system}.default;

      extension = substrateLib.mkTypescriptPackage {
        name = "akeyless-cursor-plugin";
        src = self;
        plemeLinker = plemeLinkerPkg;
      };

    in {
      packages.default = extension;

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nodejs_22
          python3
          pkg-config
        ];
        nativeBuildInputs = [ plemeLinkerPkg ];
        shellHook = ''
          echo "Akeyless Cursor Plugin development environment"
          echo "  pleme-linker resolve --project . --include-dev  - Regenerate deps.nix"
          echo "  nix build                                       - Build the extension"
        '';
      };
    });
}
