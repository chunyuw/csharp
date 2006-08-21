(TeX-add-style-hook "dn-outline"
 (lambda ()
    (TeX-run-style-hooks
     "pgf/dn-framework"
     "pgf/clr-compile-exec"
     "pgf/cts-typesystem"
     "pgf/cts-v-r-types"
     "pgf/clr-compile"
     "pgf/clr-execute"
     "pgf/fcl-namespaces")))

