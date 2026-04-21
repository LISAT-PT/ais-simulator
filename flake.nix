{
  description = "project dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            GRC_BLOCKS_PATH = "${self}/gnu-radio-ais/share/gnuradio/grc/blocks:$GRC_BLOCKS_PATH";
            PYTHONPATH = "${self}/gnu-radio-ais/lib/python3.13/site-packages:$PYTHONPATH";
            LD_LIBRARY_PATH = "${self}/gnu-radio-ais/lib:$LD_LIBRARY_PATH";


            packages = with pkgs; [
              websocat # talking to sockets
              rtl-ais
              gcc # compiling
              boost189
              zmqpp.dev
              # boost # backend libs
              cmake # compiling framework
              gnumake
              gnuradio
              autoconf
              libtool
              docutils
              cppunit
              swig
              doxygen
              python3Packages.scipy
              python3Packages.gmpy2
              python3Packages.pybind11
              python3Packages.websocket-client
              # python3Packages.gtk2
              gnuradio
              gnuradioPackages.osmosdr
              libosmocore
              spdlog
              mpir
              volk
              gmp
              # ninja # alternative to make
              # catch2_3 # testing framework
              # ccache # for caching built files
              # sqlitecpp # dependency of backend
              # sqlite # for testing
              # jq # for testing
              #
              # python3 # API
              # python3Packages.flask
              # python3Packages.flask-cors
              # curl # obvs
              # nodejs
            ];
          };
        };
    };
}
