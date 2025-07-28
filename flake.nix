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
          version = "1.98.0";

          src = builtins.fetchTarball {
            url =
              "https://windsurf-stable.codeiumdata.com/linux-x64/stable/ff497a1ec3dde399fde9c001a3e69a58f2739dac/Windsurf-linux-x64-1.10.5.tar.gz";
            sha256 = "0nzn1nnvlnkv8vzpaph21ypmi8asg17ib8ndg53ynbasc8zrgh8w";
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
