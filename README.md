# 🐔 jago

jago is a simplified markup language to author HTML pages.

## Taste of jago

Confused? Here's an annotated version of this example: [`sample.jago`](./sample.jago)

```jago
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
        a [href="https://git.sr.ht/~yuki_is_bored/jago"] "jago"
        " markup language."
```

## Use

```console
$ jago --input sample.jago --output sample.html
$ cat sample.html
<!DOCTYPE html><html lang="en"><head><title>Haruhi suzumiya's personal website</title><meta charset="
...
```

## Build

### With [Stack]

You can easily build this project using [Stack] with `stack build`.

```console
$ stack build
jago-0.1.0.0: unregistering (local file changes: CHANGELOG.md Exec/Main.hs Lib/Jago/Html.hs Lib/Jago/Parser.hs jago.cabal)
Building all executables for `jago' once. After a successful build of all of them, only specified executables will be rebuilt.
jago> configure (lib + exe)
...
```

If you want to run jago, you can use `stack run`.

```console
$ stack run -- jago --help
jago - simplified markup language to author HTML pages

Usage: jago [-i|--input INPUT] [-o|--output OUTPUT]
  Compile jago to html

Available options:
  -i,--input INPUT         Jago file acting as input
  -o,--output OUTPUT       Output html file
  -h,--help                Show this help text

https://git.sr.ht/~yuki_is_bored/jago
```

### With [Nix Flake]

You can easily build this project using [Nix Flake] with `nix build`.

```console
$ nix build
```

If you want to run jago, you can use `nix run`.

```console
$ nix run . -- --help
jago - simplified markup language to author HTML pages

Usage: jago [-i|--input INPUT] [-o|--output OUTPUT]
  Compile jago to html

Available options:
  -i,--input INPUT         Jago file acting as input
  -o,--output OUTPUT       Output html file
  -h,--help                Show this help text

https://git.sr.ht/~yuki_is_bored/jago
```

### With [Nix]

You can easily build this project using [Nix] with `nix-build`.

```console
$ nix-build
building '/nix/store/cjf2i0m8fah0qpgnww82gxkjfajgwgmx-cabal2nix-jago.drv'...
installing
this derivation will be built:
```

If you want to run jago, execute the resulting binaries inside the `result` symlink.

```console
$ ./result/bin/jago --help
jago - simplified markup language to author HTML pages

Usage: jago [-i|--input INPUT] [-o|--output OUTPUT]
  Compile jago to html

Available options:
  -i,--input INPUT         Jago file acting as input
  -o,--output OUTPUT       Output html file
  -h,--help                Show this help text

https://git.sr.ht/~yuki_is_bored/jago
```

[Stack]: https://haskellstack.org/
[Nix Flake]: https://www.tweag.io/blog/2020-05-25-flakes/
[Nix]: https://nixos.org/nix

## Contents

This repository contains the [Compiler] for Jago which utilizes the
following components:

- [Parser] which takes a Jago document turn it into an [AST]
  representation of an HTML document.
- [Render] which takes an [AST] representation and renders it out to
  an HTML document readable by web browsers.

The structure of the project allows for the use of multiple renderers,
like a code formatter, a minified render, etc.

Currently, only a HTML render is available. The output of it can be
further minified by more mature minifiers such as [html-minifier].

[Compiler]: ./Lib/Jago/Compiler.hs
[Parser]: ./Lib/Jago/Parser.hs
[AST]: ./Lib/Jago/AST.hs
[Render]: ./Lib/Jago/Render/Html.hs
[html-minifier]: https://github.com/kangax/html-minifier

## License

jago is free and open-source software licensed under the ISC license.

## See also

* [pug] (Javascript): Simplified markup language used for HTML
  templating which inspires jago.

[pug]: https://pugjs.org/api/getting-started.html
