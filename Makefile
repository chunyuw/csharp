## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn> ##

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) $(shell seq -s, 2006 $(shell $(DATE) +%Y)) "$(Author)"."

NUMTARGT  = $(shell seq 0 6)

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

BUILDDIR  = zbuild
DIROUT    = handout

all:
	@echo "Usage:"
	@echo "    make [0-8] | s[0-8] | p[0-8]"
	@echo "    make lecture | handout | a4paper | screen | article"
	@echo "    make publish | s | src | encrypt | ci | rar | 7z | swf"
	@echo "    make clean | distclean"

$(NUMTARGT): %: part-0%.pdf
part-%.pdf: part-%.tex preamble.tex
	-@mkdir -p $(BUILDDIR)
	xelatex -output-directory=$(BUILDDIR) $<
	-@mv -f $(BUILDDIR)/$@ ./m$@

encrypt: $(subst m,en-m,$(wildcard mpart-*.pdf)) $(subst sl,en-sl,$(wildcard slides*.pdf))
en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

lecture: $(NUMTARGT)
handout: screen a4paper
screen:  $(NUMTARGT:%=s-s0%.pdf)
a4paper: $(NUMTARGT:%=s-p0%.pdf)
s-s%.pdf: $(DIROUT)/s-s%.pdf; cp $< slide$@
s-p%.pdf: $(DIROUT)/s-p%.pdf; pdfjam --quiet --batch --nup 1x2 --no-landscape --outfile slide$@ $<
$(DIROUT)/s%.pdf:   $(DIROUT)/s%.tex ; xelatex -output-directory=$(@D) $<
$(DIROUT)/s-s%.tex: $(DIROUT)/pre-s.tex part-%.tex; sed -b "s|preamble|$(DIROUT)/pre-s|" $(lastword $^) > $@
$(DIROUT)/s-p%.tex: $(DIROUT)/pre-p.tex part-%.tex; sed -b "s|preamble|$(DIROUT)/pre-p|" $(lastword $^) > $@
$(DIROUT)/pre-s.tex: preamble.tex ; mkdir -p $(DIROUT); sed -b "/{beamer}/ s/,/,handout,/" $< > $@
$(DIROUT)/pre-p.tex: $(DIROUT)/pre-s.tex ; sed -b "/{handoutprint}/ s/false/true/" $< > $@

article:  $(DIROUT)/s-a.pdf;  mv $< article.pdf
$(DIROUT)/s-a.tex:  $(DIROUT)/pre-a.tex part-08.tex; sed -b "s|preamble|$(DIROUT)/pre-a|" part-08.tex > $@
$(DIROUT)/pre-a.tex: preamble.tex ; mkdir -p $(DIROUT); sed -b "/{beamer}/ s/^/%/;/a4paper/,/beamerarticle/ s/%//" $< > $@

slide%.pdf: %.pdf ;
mpart-%.pdf: part-%.pdf ; 
$(NUMTARGT:%=s%): s%: s-s0%.pdf ;
$(NUMTARGT:%=p%): p%: s-p0%.pdf ;

swf: $(NUMTARGT:%=slides-s0%.swf)
slide%.swf: slide%.pdf ; pdf2swf -B res/rfxview.swf -t $< -o $@

distclean:; -$(RM) -rv auto $(BUILDDIR) $(DIROUT) z_region* *.pdf *.7z *.zip *.rar *.swf
clean:;     -$(RM) $(wildcard en*.pdf part*.pdf z*.pdf slide*.pdf *.swf)

GITCOMMD  = push pull status st
$(GITCOMMD):; git $@
ci:; git commit -m "$(AUTOCSTR)" .
sync: pull push

s:; $(SHOWPDF)

rar:; winrar -m5 a dotnet.rar $(CURRPDF) code
7z:;  7z    -mx9 a dotnet.7z  $(CURRPDF) code

publish: $(wildcard mpart*.pdf) $(wildcard slides*.pdf)
	scp mpart-*.pdf cst.hit.edu.cn:public_html/dotnet/pdf/
	scp slides*.pdf cst.hit.edu.cn:public_html/dotnet/slides/handout/

src:; 7z a csharp-src.7z *.tex figures pgf Makefile code

.PHONY: lecture handout screen a4paper all ci clean encrypt s publish $(shell seq 0 8) $(SUBDIRS)

.SUFFIXES: .tex .pdf .dvi .ps .eps .jpg .png

# part-00.pdf: dn-intro.tex
# part-01.pdf: $(wildcard  dn-*.tex pgf/*.tex)
# part-02.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
# part-03.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
# part-04.pdf: $(wildcard lib-*.tex pgf/lib-*.tex)
# part-05.pdf: $(wildcard ado-*.tex pgf/ado-*.tex)
# part-06.pdf: $(wildcard dev-*.tex pgf/dev-*.tex)
# part-07.pdf: 
# part-08.pdf: $(wildcard *.tex pgf/*.tex)

# Local Variables:
# mode: makefile-gmake
# coding: utf-8
# End:
