# 🐔 jago

jago is a simplified markup language to author HTML pages.

This project includes both the executable which provides a
command-line interface that produces HTML files from jago markup files
and the library that work on parsing, translating and produce the
resulting HTML file.

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
        a [href="https://git.yukiisbo.red/yuki/jago"] "jago"
        " markup language."
```

## Using jago

```console
$ jago --input sample.jago --output sample.html
$ cat sample.html
<!DOCTYPE html><html lang="en"><head><title>Haruhi suzumiya's personal website</title><meta charset="
...
```

## Building jago

### With [Nix] (recommended)

You can easily build this project with [Nix] by using `nix-build`:

```console
$ nix-build release.nix
these derivations will be built:
  /nix/store/87mz16f69x31711phnx88i2din1l1jha-jago-0.1.0.0.drv
building '/nix/store/87mz16f69x31711phnx88i2din1l1jha-jago-0.1.0.0.drv'...
setupCompilerEnvironmentPhase
Build with /nix/store/4igazfl1z3vrc7cq2zs0yxwrnhsl1igf-ghc-8.10.3.
...
```

If you want to run jago, simply navigate to the result symlink:

```console
$ ls result/bin
jago
$ ./result/bin/jago --help
jago - simplified markup language to author HTML pages

Usage: jago [-i|--input INPUT] [-o|--output OUTPUT]
  Compile jago to html

Available options:
  -i,--input INPUT         Jago file acting as input
  -o,--output OUTPUT       Output html file
  -h,--help                Show this help text

https://git.yukiisbo.red/yuki/jago
```

If you want to install jago to your current Nix profile, you can use `nix-env`:

```console
$ nix-env --file release.jago --install
installing 'jago-0.1.0.0'
these derivations will be built:
  /nix/store/10nmg713p08j1jqv4il0iypzmy451zxm-jago-0.1.0.0.drv
building '/nix/store/10nmg713p08j1jqv4il0iypzmy451zxm-jago-0.1.0.0.drv'...
...
```

### With [Cabal]

Assuming you have a recent version of [Cabal], you can build the project with `cabal build`:

```console
$ cabal build
Resolving dependencies...
Build profile: -w ghc-8.8.4 -O1
In order, the following will be built (use -v for more details):
 - jago-0.1.0.0 (lib) (first run)
 - jago-0.1.0.0 (exe:jago) (first run)
...
```

If you want to run jago, you can use `cabal run`:

```console
$ cabal run -- jago --help
Up to date
jago - simplified markup language to author HTML pages

Usage: jago [-i|--input INPUT] [-o|--output OUTPUT]
  Compile jago to html

Available options:
  -i,--input INPUT         Jago file acting as input
  -o,--output OUTPUT       Output html file
  -h,--help                Show this help text

https://git.yukiisbo.red/yuki/jago
```

If you want to install jago, simply use `cabal install`

```console
$ cabal install
Wrote tarball sdist to
/home/hs/work/jago/dist-newstyle/sdist/jago-0.1.0.0.tar.gz
Resolving dependencies...
Build profile: -w ghc-8.8.4 -O1
In order, the following will be built (use -v for more details):
 - jago-0.1.0.0 (lib) (requires build)
 - jago-0.1.0.0 (exe:jago) (requires build)
Starting     jago-0.1.0.0 (lib)
Building     jago-0.1.0.0 (lib)
...
```

## License

jago is free and open-source software licensed under the ISC license.

## See also

* [pug] (Javascript): Simplified markup language used for HTML
  templating which inspires jago.

[Nix]: https://nixos.org/nix
[Cabal]: https://www.haskell.org/cabal/
[pug]: https://pugjs.org/api/getting-started.html
