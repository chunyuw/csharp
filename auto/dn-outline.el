(TeX-add-style-hook "dn-outline"
 (lambda ()
    (TeX-run-style-hooks
     "pgf-dn/dn-framework"
     "pgf-dn/cts-typesystem"
     "pgf-dn/cts-v-r-types"
     "pgf-dn/clr-compile"
     "pgf-dn/clr-execute"
     "pgf-dn/fcl-namespaces")))

