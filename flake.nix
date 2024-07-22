{
  description = "WSL2 Linux Kernel";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = inputs@{ self, flake-parts, nixpkgs }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem = { config, pkgs, ... }: {
        packages.default = pkgs.callPackage ./kernel.nix { };
        devShells.default = config.packages.default;
      };
    };
}
