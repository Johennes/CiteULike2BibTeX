CiteULike2BibTeX
================

*Mirrors: [GitHub] ~ [GitLab]*

A CiteULike to BibTeX conversion tool

This is a shell script that downloads a user's CiteULike library to a BibTeX
file. The script relies on wget, mktemp, awk and sed.

### Usage

```text
citeulike2bibtex.sh [OPTION...]

Options:
  -u, --user     CiteULike username
  -o, --output   Output filename
  -h, --help     Display this message and exit
```

CiteULike's export configuration can be adapted in the script's
_Standard CiteULike settings_ section. In addition, the script offers a number
of processing options which can be configured in its _Additional settings_
section. These include:

* Blacklisting unneeded BibTeX keys
* Stripping trailing '+' characters on pages fields
* Unescaping math commands

[GitHub]: https://github.com/Johennes/CiteULike2BibTeX
[GitLab]: https://gitlab.com/cherrypicker/CiteULike2BibTeX
