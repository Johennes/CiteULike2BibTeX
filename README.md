CiteULike2BibTeX
================

A CiteULike to BibTeX conversion tool

This is a shell script that downloads a user's CiteULike library to a BibTeX
file. The script relies on wget, mktemp, awk and sed.

### Usage

``` shell
citeulike2bibtex.sh [OPTION...]

Options:
  -u, --user     CiteULike username
  -o, --output   Output filename
  -h, --help     Display this message and exit
```

CiteULike's export configuration can be adapted in the script's
'Standard CiteULike settings' section. In addition, the script offers a number
of processing options which can be configured in its 'Additional settings'
section. These include

* blacklisting unneeded BibTeX keys
* stripping trailing '+' characters on pages fields
* unescaping math commands
