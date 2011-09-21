## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn> ##

PRGFILES  = Makefile auto/*.el
TXTFILES  = {.,pgf}/*.tex $(PRGFILES) OUTLINE.txt code/*.cs figures/*.txt .dired 
BINFILES  = figures/*.{jpg,png,pdf} res/*.7z

NUMTARGT  = $(shell seq 0 8)
NUMTARGT2 = $(shell seq 0 5)
PDFTARGT  = $(NUMTARGT:%=part-0%.pdf)

AUTOCSTR  = Batch checkin by Makefile ($(shell $(DATE) "+%Y-%m-%d %H:%M") on $(shell uname -n))
ifeq ($(shell uname -s), windows32) 
  DATE    = gdate
else 
  DATE    = date
endif

ifneq ($(strip $(wildcard *.pdf)),)
  SHOWPDF = start $(shell ls -t -1 $(wildcard *.pdf) |head -1)
  CURRPDF = $(wildcard *.pdf)
else
  SHOWPDF = @echo "no pdf files"
  CURRPDF = no-this-file
endif

PASSWORD  = cy.net

CLSUFFIX  = aux log snm toc vrb out out.bak dvi nav
GITCOMMD  = push pull sync status st

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) $(shell seq -s, 2006 $(shell $(DATE) +%Y)) "$(Author)"."

BUILDDIR  = zbuild
DIRDIR    = handout

all:
	@echo "Usage:"
	@echo "    make [0-8] | s | encrypt | handout { a4paper | screen }"
	@echo "    make cpdf | clean | cleanall | distclean"
	@echo "    make ci | st | push | pull | rar | 7z"

$(NUMTARGT): %: part-0%.pdf

$(PDFTARGT): %.pdf: %.tex preamble.tex
	xelatex -output-directory=$(BUILDDIR) $<
	-@mv -f $(BUILDDIR)/$@ ./m$@

encrypt: $(subst m,en-m,$(wildcard mpart-*.pdf)) $(subst sl,en-sl,$(wildcard slides*.pdf))
en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

lecture: $(NUMTARGT2)
handout: screen a4paper
screen:  $(NUMTARGT2:%=s-s0%.pdf)
a4paper: $(NUMTARGT2:%=s-p0%.pdf)
s-s%.pdf: $(DIRDIR)/s-s%.pdf ; cp $< slide$@
s-p%.pdf: $(DIRDIR)/s-p%.pdf ; pdfjam --batch --nup 1x2 --no-landscape --outfile slide$@ $<
$(DIRDIR)/s%.pdf: $(DIRDIR)/s%.tex ; xelatex -output-directory=$(@D) $<
$(DIRDIR)/s-s%.tex: $(DIRDIR)/spre.tex part-%.tex; sed -b -e "s|preamble|$(DIRDIR)/spre|" $(lastword $^) > $@
$(DIRDIR)/s-p%.tex: $(DIRDIR)/ppre.tex part-%.tex; sed -b -e "s|preamble|$(DIRDIR)/ppre|" $(lastword $^) > $@
$(DIRDIR)/spre.tex: preamble.tex ; mkdir -p $(DIRDIR); sed -b -e "s/\[13/\[handout,13/" $< > $@
$(DIRDIR)/ppre.tex: preamble.tex
	mkdir -p $(DIRDIR); sed -b -e "s/\[13/\[handout,13/" -e "s/\(print..\)false/\1true/"  $< > $@

distclean: cleanall tclean

cleanall: cpdf clean

cpdf:;  -$(RM) $(wildcard en-*.pdf part-*.pdf slides-*.pdf test.pdf z_region.pdf)

clean:; -$(RM) $(foreach s,$(CLSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe */z_region*)

tclean:; -$(RM) -rf $(foreach s,test z_region,$(wildcard $(s).* */$(s).*))

$(GITCOMMD):; git $@
ci:; git commit -m "$(AUTOCSTR)" .

s:; $(SHOWPDF)

rar:; winrar -m5 a dotnet.rar $(CURRPDF) code
7z:;  7z    -mx9 a dotnet.7z  $(CURRPDF) code

publish: $(wildcard mpart-*.pdf) $(wildcard slides*.pdf)
	scp mpart-*.pdf cst.hit.edu.cn:public_html/dotnet/pdf/
	scp slides*.pdf cst.hit.edu.cn:public_html/dotnet/slides/handout/

# DIRNAME = dotnet
# src:; (cd ..; 7z a $(DIRNAME)-src.7z $(DIRNAME) -xr@$(DIRNAME)/res/srcexclude.txt)

.PHONY: all ci clean cleanall cpdf encrypt s st $(shell seq 0 8)  $(SUBDIRS)

.SUFFIXES: .tex .pdf .dvi .ps .eps .jpg .png

part-00.pdf: dn-intro.tex
part-01.pdf: $(wildcard  dn-*.tex pgf/*.tex)
part-02.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
part-03.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
part-04.pdf: $(wildcard lib-*.tex pgf/lib-*.tex)
part-05.pdf: $(wildcard ado-*.tex pgf/ado-*.tex)
part-06.pdf: $(wildcard dev-*.tex pgf/dev-*.tex)
part-07.pdf: 
part-08.pdf: $(wildcard *.tex pgf/*.tex)

# Local Variables:
# mode: makefile-gmake
# coding: utf-8
# End:
