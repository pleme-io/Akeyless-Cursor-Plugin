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
      # NOTE: buildNpmPackage fails because keytar requires node-gyp with native
      # platform libs (libsecret on Linux, Security.framework on macOS).
      # Build with: npm install && npm run compile && vsce package

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nodejs_22
          python3
          pkg-config
        ];
      };
    });
}
