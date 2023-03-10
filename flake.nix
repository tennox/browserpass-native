{
  description = "";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, devshell, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let
          pkgs = import nixpkgs {
            inherit system;

            overlays = [ devshell.overlays.default ];
          };
        in
        pkgs.devshell.mkShell {
          #imports = [ (pkgs.devshell.importTOML ./devshell.toml) ]; - in case you want to enable devshell.toml support

          devshell.packages = with pkgs; [
              nixpkgs-fmt # for editing this file

              # YOUR PACKAGES HERE #
          ];
        };
    });
}
