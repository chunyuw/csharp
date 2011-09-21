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
GITCOMMD  = push pull status st

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) $(shell seq -s, 2006 $(shell $(DATE) +%Y)) "$(Author)"."

BUILDDIR  = zbuild
DIROUT    = handout

all:
	@echo "Usage:"
	@echo "    make [0-8] | lecture | handout | a4paper | screen"
	@echo "    make publish | s | src | encrypt | ci | rar | 7z"
	@echo "    make cpdf | clean | cleanall | distclean"

$(NUMTARGT): %: part-0%.pdf

$(PDFTARGT): %.pdf: %.tex preamble.tex
	mkdir -p $(BUILDDIR)
	xelatex -output-directory=$(BUILDDIR) $<
	-@mv -f $(BUILDDIR)/$@ ./m$@

encrypt: $(subst m,en-m,$(wildcard mpart-*.pdf)) $(subst sl,en-sl,$(wildcard slides*.pdf))
en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

lecture: $(NUMTARGT2)
handout: screen a4paper
screen:  $(NUMTARGT2:%=s-s0%.pdf)
a4paper: $(NUMTARGT2:%=s-p0%.pdf)
s-s%.pdf: $(DIROUT)/s-s%.pdf ; cp $< slide$@
s-p%.pdf: $(DIROUT)/s-p%.pdf ; pdfjam --batch --nup 1x2 --no-landscape --outfile slide$@ $<
$(DIROUT)/s%.pdf: $(DIROUT)/s%.tex ; xelatex -output-directory=$(@D) $<
$(DIROUT)/s-s%.tex: $(DIROUT)/spre.tex part-%.tex; sed -b -e "s|preamble|$(DIROUT)/spre|" $(lastword $^) > $@
$(DIROUT)/s-p%.tex: $(DIROUT)/ppre.tex part-%.tex; sed -b -e "s|preamble|$(DIROUT)/ppre|" $(lastword $^) > $@
$(DIROUT)/spre.tex: preamble.tex ; mkdir -p $(DIROUT); sed -b -e "s/\[13/\[handout,13/" $< > $@
$(DIROUT)/ppre.tex: preamble.tex
	mkdir -p $(DIROUT); sed -b -e "s/\[13/\[handout,13/" -e "s/\(print..\)false/\1true/"  $< > $@

distclean:; -$(RM) -rv $(BUILDDIR)/* $(DIROUT) z_region* */z_region* *.{pdf,7z,zip,rar}
clean:;     -$(RM) $(wildcard en*.pdf part*.pdf z*.pdf slide*.pdf)

$(GITCOMMD):; git $@
ci:; git commit -m "$(AUTOCSTR)" .
sync: pull push

s:; $(SHOWPDF)

rar:; winrar -m5 a dotnet.rar $(CURRPDF) code
7z:;  7z    -mx9 a dotnet.7z  $(CURRPDF) code

publish: $(wildcard mpart-*.pdf) $(wildcard slides*.pdf)
	scp mpart-*.pdf cst.hit.edu.cn:public_html/dotnet/pdf/
	scp slides*.pdf cst.hit.edu.cn:public_html/dotnet/slides/handout/

src:; 7z a csharp-src.7z *.tex figures pgf Makefile code

.PHONY: lecture handout screen a4paper all ci clean encrypt s publish $(shell seq 0 8) $(SUBDIRS)

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
