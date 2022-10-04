{
  description = "AdGuardSDNSFilter";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.inputs.flake-utils.follows = "fup/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, fup, devshell, ... }:
    fup.lib.mkFlake {
      inherit self inputs;
      supportedSystems = [ "x86_64-linux" ];

      sharedOverlays = [ devshell.overlay ];

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs;
        in rec {
          devShell = pkgs.devshell.mkShell {
            motd = "";
            packages = with pkgs; [ yarn ];
          };
        };
    };
}
