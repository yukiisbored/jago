# 🐔 cock

cock is a simplified markup language to author HTML pages.

This project includes both the executable which provides a
command-line interface that produces HTML files from cock markup files
and the library that work on parsing, translating and produce the
resulting HTML file.

## Taste of cock

Confused? Here's an annotated version of this example: [`sample.cock`](./sample.cock)

```cock
"<!DOCTYPE html>"
html [lang="en"]
  head
    title "Haruhi suzumiya's personal website"

    meta [charset="utf-8"]
    meta [name="viewport"
          content="width=device-width, initial-scale=1"]
    meta [name="description"
          content="Haruhi's personal space on the wild wild web"]

  body
    header
      img [src="//upload.wikimedia.org/wikipedia/en/4/48/Suzumiya_Haruhi.jpg"
           alt="Picture of myself"]
      h1 "Haruhi Suzumiya"
      h2 i "President of the SOS Brigade club"

    div [class="border"]
      h3 "Biography"
      p "Hello, world! Welcome to my small space on the corner of the web. "
        "I'm a high school student from Nishinomiya, Japan and interested in "
        `"supernatural phenomena" and "figures", such as `
        a [href="//en.wikipedia.org/wiki/Extraterrestrial_life"] "aliens"
        ", "
        a [href="//en.wikipedia.org/wiki/Time_travel"] "time travelers"
        ", and "
        a [href="//en.wikipedia.org/wiki/Esper"] "espers"
        ". If you know any, please let me know by shooting me an email at "
        a [href="mailto:haruhi.suzumiya@example.jp"] "haruhi.suzumiya@example.jp"
        "."

    div [class="border"]
      h3 "Members"
      ul li "Haruhi Suzumiya"
         li "Mikuru Asahina"
         li "Yuki Nagato"
         li "Itsuki Koizumi"
         li "Kyon"

    footer
      p "This webpage is authored using the "
        a [href="https://git.yukiisbo.red/yuki/cock"] "cock"
        " markup language."
```

## Using cock

```console
% cock --input sample.cock --output sample.html
% cat sample.html
<!DOCTYPE html>
<html lang="en"><head><title>Haruhi suzumiya's personal website</title><meta charset="
...
```

## Building cock

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

## See also

* [pug] (Javascript): Simplified markup language used for HTML
  templating which inspires cock.

[Nix]: https://nixos.org/nix
[Cabal]: https://www.haskell.org/cabal/
[Unlicense]: https://unlicense.org/
[pug]: https://pugjs.org/api/getting-started.html
