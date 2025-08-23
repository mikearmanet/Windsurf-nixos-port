{
  description = "Windsurf flake for linux x86-64";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; }; {
        packages.default = stdenv.mkDerivation (finalAttrs: {
          pname = "windsurf";
          version = "1.99.0";

          src = builtins.fetchTarball {
            url =
              "https://windsurf-stable.codeiumdata.com/linux-x64/stable/b8f002c02d165600299a109bf21d02d139c52644/Windsurf-linux-x64-1.12.2.tar.gz";
          };

          nativeBuildInputs = [
            alsa-lib
            at-spi2-atk
            xorg.libxcb
            libdrm
            nss_latest
            cups
            wrapGAppsHook3
            libgbm
            xorg.libxkbfile
            autoPatchelfHook
          ];
          runtimeDependencies = [ (lib.getLib udev) ];

          postUnpack = "cp -r $src $out";

          meta = {
            description = "The new purpose-built IDE to harness magic";
            homepage = "https://windsurf.com";
            license = lib.licenses.unfree;
            maintainers = with lib.maintainers; [ hitentandon ];
          };
        });

        formatter = nixfmt-classic;
      });
}
