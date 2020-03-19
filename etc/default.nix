{ pkgs ? import <nixpkgs> {}, ... }:

  with pkgs;

    let
      emacsWithPackages = (emacsPackagesNgGen emacs).emacsWithPackages;

        emacs-build = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
          epkgs.org epkgs.htmlize
        ]));

          emacs-run = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
            epkgs.anaphora
            epkgs.dash
            epkgs.eredis
            epkgs.hide-lines
            epkgs.s
          ]));

            sophoslib = stdenv.mkDerivation rec {
              name = "sophoslib";
                buildInputs = [ emacs-build ];
                src = ./.;
                buildPhase = ''
                  mkdir -p $out
                  source $stdenv/setup; ln -s $env $out
                  ${emacs-build}/bin/emacs --batch -l ./etc/build.el  --eval "(build-all)"
                '';
                    installPhase = ''
                      cp ./etc/load.el $out
                      cp ./core/el/* $out
                      cp ./plugins/el/* $out
                    '';
            };

    in writeShellScriptBin "sophos" ''
      #!${stdenv.shell}
      ${emacs-run}/bin/emacs -nw -q -L ${sophoslib} -l ${sophoslib}/load.el
    ''
