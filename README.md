# cock

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
      A [href="mailto:haruhi.suzumiya@yahoo.jp"] "haruhi.suzumiya@yahoo.jp"
    Hr
    H6 "All content on this website is released to the public domain."
```
