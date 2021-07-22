{ mkDerivation, base, indents, optparse-applicative, parsec, stdenv
, text
}:
mkDerivation {
  pname = "jago";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base indents parsec text ];
  executableHaskellDepends = [
    base indents optparse-applicative parsec text
  ];
  description = "Simplified markup language to author HTML pages";
  license = stdenv.lib.licenses.publicDomain;
}
