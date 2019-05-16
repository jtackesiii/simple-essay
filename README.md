# simple-essay

## Personal Notes:

### To create new project

  - Create new git repo

  - Skip instantiating it with README.md

  - Copy SSH key

  - Clone repo to intended folder

  - Copy over this project

  - Change .git/config.toml origin url to [SSH key]

### LaTex template format

- For rendering a book: "~\BIN\book.ps1"
- For rendering an article: "~\BIN\article.ps1"

## ToDO:

## Old README excerpts

This repository provides a bare minimum of files to generate a tidy academic
paper with markdown that, nevertheless, is published as both a Microsoft Word
`.docx` and as a `.pdf` (see
[output.docx](https://github.com/plain-plain-text/simple-essay/blob/master/output.docx)
and
[output.pdf](https://github.com/plain-plain-text/simple-essay/blob/master/output.pdf)
respectively). The conversion is done by the universal document

### Writing Scholarly Markdown

The two main differences between writing regular Markdown and scholarly
Markdown are the introduction of footnotes and citations.

#### Footnotes

Footnotes are written inline with the text itself. This is similar to the way
applications like Scrivener treat footnotes. In other words, you write them
like this:

```markdown
It was important to remember that, during this battle, the sides were hardly
evenly matched.^[In fact, contemporary sources posit that one side had nearly
ten times as many soldiers.] Nevertheless, the battle started precisely at
noon.
```

Note the syntax: a `^`, followed by the contents of the footnote enclosed in
`[]`.

If your footnotes need to grow to multiple paragraphs, please see the Pandoc
documentation for “[regular
footnotes](https://pandoc.org/MANUAL.html#footnotes)” (those described above
are “inline footnotes”).

#### Citations

The `.bib` database, `bibliography.bib`, is written in the
[BibLaTeX](https://ctan.org/pkg/biblatex?lang=en). Every entry to the database
begins with its type (`@book`, for example), followed by its *citation key*.
In the case of the `bibliography.bib` included in this repo, the very first
citation key is `barnes_nightwood_1995`.

When exporting a collection from Zotero as BibLaTeX (by right- or
control-clicking on the collection and choosing “Export Collection…”), Zotero
will auto-create citation keys of the format `author_title_year`.

Citing a work in the `.bib` file is done using the citation key. In Markdown,
the typical format to do so is:

```markdown
The narrator refers to Guideo Volkbein as “both a gourmet and a dandy, never
appearing in public without the ribbon of some quite unknown distinction
tinging his buttonhole with a faint thread”[@barnes_nightwood_1995 3].
```

The citation syntax is rather flexible and forgiving. The Pandoc documentation
provides [a few other examples](https://pandoc.org/MANUAL.html#citations):

```markdown
Blah blah [see @doe99, pp. 33–35; also @smith04, chap. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

A minus sign (-) before the @ will suppress mention of the author in the citation. This can be useful when the author is already mentioned in the text:

```markdown
Smith says blah [-@smith04].
```

You can also write an in-text citation, as follows:

```markdown
@smith04 says blah.

@smith04 [p. 33] says blah.
```

Long citation keys can be cumbersome and can be difficult to remember.
Installing the [Better BibTeX](https://retorque.re/zotero-better-bibtex/)
plugin for Zotero will let you define citation keys from within Zotero itself
by adding a line `bibtex: citation-key` in the “Extras” field in Zotero. That
is how, in the default `bibliography.bib`, the standard edition of _Nightwood_
has a citation key of simply `nightwood`, not `barnes_nightwood_1936`.

Finally, often users will have one, giant .bib file that represents every
citation they have saved. If this is the case for you, then, obviously, the
`bibliography` key needs to be changed in `metadata.yml` to point to that
file. However, in that case, you can also benefit from using the
[autocomplete-bibtex](https://atom.io/packages/autocomplete-bibtex) plugin for
Atom that will auto-suggest citations for you.

### Metadata.yml

The `metadata.yml` file contains information that is passed both to Pandoc
itself and to LaTeX via the settings in `template.tex`.

* `title`: This is the title of the essay or chapter.
* `author`: This is an array of potential authors, with one listed. Each
author can have three keys, of which the latter two can be blank:
    * `name`: The author’s name
    * `affiliation`: The author’s academic affiliation
    * `email`: The author’s email
* `bibliography_X`: See multiple-bibliography
* `notes-after-punctuation`, `csl`, `link-citations`: These are specific
values that Pandoc-citeproc handles. Please see the [Pandoc-citeproc
documentation](https://github.com/jgm/pandoc-citeproc/blob/master/man/pandoc-citeproc.1.md)
for more information on these keys. The `csl` refers to a [Citation Style
Language](https://citationstyles.org/) file. By default, Pandoc-citeproc uses
the [`chicago-author-date`
style](https://github.com/citation-style-language/styles/blob/master/chicago-author-date.csl).
See below for more information on CSL.
* `nocite`: If set to `"@*"`, the entire contents of `bibliography.bib` will
be printed in the bibliography, even if works remain uncited.
* `epigraph`: This is an array of potential epigraphs, with two listed. Each
epigraph should have two keys:
    * `text`: The text of the epigraph
    * `source`: The source of the epigraph
`pdf-options`: This is a list of options for generating the pdf. They should
be somewhat self-explanatory.
    * `font`: This key, however, is a bit tricky, and it is commented out by
    default, because it is hard to predict what fonts are on someone’s
    computer. If you download and install [EB
    Garamond](http://www.georgduffner.at/ebgaramond/index.html), then you can
    uncomment the line as it is and have the pdf output typeset in EB
    Garamond.
    * `font-settings`: This is a subgroup of font settings that may not apply
    to all fonts.

### Citation Style Language Files

A brief list of [CSL](http://citationstyles.org) files to download. Once you
download the file, you should drop it into the same folder as this repository
and then set the `csl` key in `metadata.yml` to point to the file.

### multiple-bibliographies

(does not work for .docx, which reads generated bibs as "body text")

This filter allows to create multiple bibliographies using
`pandoc-citeproc`. The content of each bibliography is controlled
via YAML values and the file in which a bibliographic entry is
specified.

#### Usage

Instead of using the usual *bibliography* metadata field, all
bibliographies must be defined via a separate field of the scheme
*bibliographyX*, e.g.

    ---
    bibliography_main: main-bibliography.bib
    bibliography_software: software.bib
    ---

The placement of bibliographies is controlled via special divs in bibliography.md.

    # References

    ::: {#refs_main}
    :::

    # Software

    ::: {#refs_software}
    :::

Each refsX div should have a matching bibliographyX entry in the
header. These divs are filled with citations from the respective
bib-file.

Finally, in the pandoc command, add "--lua-filter=/Users/jtack/AppData/Roaming/pandoc/multiple-bibliographies.lua"
