# focusadl – A LaTeX class for FOCUS Adelaide documents

`focusadl` is a LaTeX class for typesetting documents, Bible studies and
booklets for FOCUS Adelaide in line with the AFES unified branding guidelines.
(See the [`afesbrand`](https://github.com/dcpurton/afesbrand) package.)

The class includes various page layouts, multi-lingual support, and a set of
environments for boxed Scripture quotations (with the help of the
[`scripture`](https://github.com/dcpurton/scripture) package.

## Installation

The `focusadl` package uses the `l3build` system. To install, clone the GitHub
repository and run `l3build install` to install the package in your local TeX
tree.

## Usage

### Document title

A simple title can be set using:

```TeX
\title{Study title}
\passage{Bible reference}
\maketitle
```

A full page title page inside the AFES Brand Grid System can by produced using
the `titlepage` environment. A simple full page title page can be inserted
with `\maketitle` if the `titlepage` option is passed to the class.

### Document imprint page

A copyright imprint page can be inserted with the `\imprintpage` command. A
copyright statement for Bible quotations from the NIVUK version is included.
This can be changed by defining and assigning a new socket plug to the
`focusadl/biblecopyright` socket.

### Document layout

The following document layouts are supported using the `layout` class option:

- Default: Output a single page document.
- `layout=2 on 1`: Output 2 pages per page on an A4 landscape page.
- `layout=repeated 2-up`: Output 2 pages per page on an A4 landscape page
  where the two pages on each page are repeated.

### Document type

The following document types are supported using the `type` class option:

- `handout`: Loads the `article` base class.
- `booklet`: Loads the `book` base class.

### Question spacing

The class auto-spaces `enumerate` items. The spacing can be set using the
`spaces` class option:

- `spaces=normal | tighter | looser`

Also available is `\FOCUSAdlSpace[<value>=1]` which inserts the standard space
multiplied by `<value>` and `\FOCUSAdlSpaceSkip{<value>}` which inserts the
standard space multiplied by `<value>` as a skip.

### Multi-lingual support

Use `\FOCUSAdlLoadLanguage{<language>}` to load a language file. The following
languages are supported:

- chinese

### Emoji support

Emojis can be entered directly with no mark up. Use
`\FOCUSAdlLoadModule{emoji}` to enable this feature.

### Keyword highlighting

Use `\FOCUSAdlLoadModule{keywords}` to enable this feature.

The `FOCUSAdlHighlightKeywords` environment can be used to highlight keywords
in a block of text.

The colours and words are set up using the
`\FOCUSAdlAddKeywords{<colour>}{<comma separated list of words/phrases>}`.

A limitation is that for a phrase to be correctly highlighted, it must appear
on one line in the input file.

Occasionally you may want to highlight the same word in different colours
depending on context. One way to do this is to put a Zero-Width-Joiner
character in one of the words to distinguish it and highlight that word in a
different colour.

### Boxes

Two kinds of boxes are supported: `herobox` and `accentbox`.

`herobox` creates a box in the AFES unified branding hero colour with rounded
corners.

`accentbox` creates a square cornered box in the AFES unified branding accent
colour. Three types of `accentbox` are supported:

- `type=onecolumn` (default): Set a standard single column breakable box.
- `type=twocolumn`: Set a two column breakable box.
- `type=parallel`: Set a two column breakable box with parallel content (e.g.,
  for setting the Bible in two languages in parallel). The ratio of column
  widths can be set using the `ratio` option (default: `0.5`).

A horizontal line can be inserted with `\newsegment` and you can switch to the
second column in a parallel box with `\secondcolumn`.

### Tables

For tables, use `\FOCUSAdlLoadModule{tables}`. This loads the `tabularray`
package with the `booktabs` library and sets up simple `FOCUSAdlTable` and
`FOCUSAdlLongTable` environments taking `tabularray` options in their first
argument). The font in the first row is set to `\fontseries{sb}`.

### Miscellaneous commands

`\gap[<options>]`: Insert a fill in the gap line. Supported options are `text`
to specify an default text and `width` for the width of the gap as a skip
expression.

### Leader notes

Leader notes can be inserted using the `leadernotes` environment and
`\textleadernotes` function. `\textleadernotes*` ends the paragraph at the end
of the function. The optional first argument of the command and environment
allows a `colour` (default: `black!40`) and `font` (default:
`\fontseries{m}\sffamily\footnotesize`) to be set.

There is also a `\IFUseLeaderNotesTF` conditional available.

## Licence

```
Copyright (c) 2026 David Purton <david.purton@afes.org.au>

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3c of this license
or (at your option) any later version. The latest version of this
license is in
   http://www.latex-project.org/lppl.txt
and version 1.3c or later is part of all distributions of LaTeX
version 2005/12/01 or later.

This work is "maintained" (as per the LPPL maintenance status)
by David Purton.
```
