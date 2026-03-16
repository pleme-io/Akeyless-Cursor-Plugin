{
  description = "VS Code / Cursor extension for managing Akeyless secrets and scanning for hardcoded secrets";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pleme-linker = {
      url = "github:pleme-io/pleme-linker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: (import "${inputs.substrate}/lib/repo-flake.nix" {
    inherit (inputs) nixpkgs flake-utils;
  }) {
    self = inputs.self;
    language = "typescript";
    builder = "package";
    pname = "akeyless-cursor-plugin";
    plemeLinker = inputs.pleme-linker;
    description = "VS Code / Cursor extension for managing Akeyless secrets and scanning for hardcoded secrets";
    homepage = "https://github.com/pleme-io/Akeyless-Cursor-Plugin";
  };
}
