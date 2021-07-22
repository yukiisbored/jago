{
  description = "Simplified markup language to author HTML pages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        packageName = "jago";

        pkgs = import nixpkgs { inherit system; };
        haskellPackages = pkgs.haskellPackages;

        jailbreakUnbreak = pkg:
          pkgs.haskell.lib.doJailbreak (pkg.overrideAttrs (_: { meta = { }; }));

        package = haskellPackages.callCabal2nix packageName self rec {};
        packages.${packageName} = package;
      in {
        inherit packages;
        defaultPackage = package;

        devShell = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            haskell-language-server
            brittany
            ghcid
            stack
          ];

          inputsFrom = builtins.attrValues packages;
        };
      });
}
