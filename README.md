# focusadl – A LaTeX class for FOCUS Adelaide documents

`focusadl` is a LaTeX class for typesetting documents, Bible studies and
booklets for FOCUS Adelaide in line with the AFES unified branding guidelines.
(See the [`afesbrand`](https://github.com/dcpurton/afesbrand) package.)

The class includes various page layouts, multi-lingual support, and a set on
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
`spacing` class option:

- `spacing=normal | tighter | looser`

### Multi-lingual support

Use `\FOCUSAdlLoadLanguage{<language>}` to load a language file. The following
languages are supported:

- chinese

### Boxes

Two kinds of boxes are supported: `herobox` and `accentbox`.

`herobox` creates a box in the AFES unified branding hero colour with rounded
corners.

`accentbox` creates a square cornered box in the AFES unified branding accent
colour. Three types of `accentbox` are supported:

- `type=onecolumn` (default): Set a standard single column breakable box.
- `type=twocolumn`: Set a two column breakable box.
- `type=parallel`: Set a two column breakable box with parallel content (e.g.,
  for setting the Bible in two languages in parallel).

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
