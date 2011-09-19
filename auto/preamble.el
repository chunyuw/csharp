(TeX-add-style-hook "preamble"
 (lambda ()
    (TeX-add-symbols
     "helplines"
     "wraphere"
     "cmd"
     "redwarn"
     "xnode"
     "CJKindent")
    (TeX-run-style-hooks
     "pgfpages"
     "tikz"
     "listings"
     "xeCJK"
     "fullpage"
     "hyperref"
     "amssymb"
     "xcolor"
     "svgnames"
     "ifthen"
     "latex2e"
     "beamer10"
     "beamer"
     "13pt"
     "table"
     "xetex")))

