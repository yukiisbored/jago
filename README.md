# 🐔 cock

cock is a simplified markup language to author HTML pages.

This project includes both the executable which provides a
command-line interface that produces HTML files from cock markup files
and the library that work on parsing, translating and produce the
resulting HTML file.

## Taste of cock

```cock
"<!DOCTYPE html>"
Html [lang="en"]
  Head
    Title "Haruhi suzumiya personal website"

    Meta [charset="utf-8"]
    Meta [name="viewport" content="width=device-width, initial-scale=1"]

    Meta [name="description" content="Haruhi's personal space on the wild wild web"]

    Link [rel="stylesheet" href="styles.css"]
  Body
    H1 "Haruhi Suzumiya"
    Hr
    P
      "Hello, world! Welcome to my small space on the corner of the web."
      "I'm a high school student from Nishinomiya, Japan and interested in "
      "supernatural phenomena and figures, such as "
      A [href="/aliens"] "aliens"
      ", "
      A [href="/time-travelers"] "time travelers"
      ", and "
      A [href="/time-travelers"] "espers"
      ". If you know any, please let me know by shooting me an email at "
      A [href="mailto:haruhi.suzumiya@example.jp"] "haruhi.suzumiya@example.jp"
    Hr
    H6 "All content on this website is released to the public domain."
```

## Build

### With [Nix] (recommended)

You can easily build this project with [Nix], by running the following command:

```console
% nix-build release.nix
% # The resulting build will be at the result folder
```

### With [Cabal]

Assuming you have a recent version of [Cabal], you can build the project with the following:

```console
% cabal build
% # If you want to run the software, you can use cabal run
% cabal run -- cock --help
% # If you want to install, simply use cabal install
% cabal install
```

## License

cock is free and unencumbered public domain software. For more
information, see http://unlicense.org/ or the accompanying LICENSE
file.

[Nix]: https://nixos.org/nix
[Cabal]: https://www.haskell.org/cabal/
[Unlicense]: https://unlicense.org/
