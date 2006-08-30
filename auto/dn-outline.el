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
     "pgf-dn/dn-framework"
     "pgf-dn/clr-compile-exec"
     "pgf-dn/cts-typesystem"
     "pgf-dn/cts-v-r-types"
     "pgf-dn/clr-compile"
     "pgf-dn/pe-format"
     "pgf-dn/clr-execute"
     "pgf-dn/fcl-namespaces")))

