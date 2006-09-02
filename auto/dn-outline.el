(TeX-add-style-hook "dn-outline"
 (lambda ()
    (LaTeX-add-labels
     "fig:dn-framework"
     "fig:clr-compile-exec"
     "fig:cts-typesystem"
     "fig:cts-v-r-types"
     "fig:clr-compile"
     "fig:clr-execute")
    (TeX-run-style-hooks
     "pgf/dn-framework"
     "pgf/clr-compile-exec"
     "pgf/cts-typesystem"
     "pgf/cts-v-r-types"
     "pgf/clr-compile"
     "pgf/pe-format"
     "pgf/clr-execute"
     "pgf/fcl-namespaces")))

