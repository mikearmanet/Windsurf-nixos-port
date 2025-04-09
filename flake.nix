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
          version = "1.97.0";

          src = builtins.fetchTarball {
            url =
              "https://windsurf-stable.codeiumdata.com/linux-x64/stable/f8ec5d648c43a2f1e54dccd12e2cf74f5ae6bad9/Windsurf-linux-x64-1.6.3.tar.gz";
            sha256 = "1b3ygc200ca64d5bml4hkxir8vzribkx9nqwqx4b7by2k2yj38y8";
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

          postUnpack = ''
            echo $src
            cp -r $src $out
          '';

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
