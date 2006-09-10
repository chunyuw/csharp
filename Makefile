## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) 2006 Chunyu Wang."

TXTFILES  = Makefile *.tex pgf/*.tex pgf/auto/*.el Outline.org auto/*.el code/*.cs logo/Makefile logo/*.mp figures/*.txt
BINFILES  = figures/*.jpg figures/*.png figures/*.pdf figures/*.ppt

NUMTARGT  = $(shell seq 0 8)
PDFTARGT  = $(NUMTARGT:%=part-0%.pdf)

AUTOCSTR  = Batch checkin by Makefile ($(shell $(DATE) "+%Y%m%d-%H:%M"))
ifeq ($(shell uname),"windows32") 
  DATE = gdate
else 
  DATE = date
endif

ifneq ($(strip $(wildcard *.pdf)),)
  SHOWPDF = start $(shell ls -t -1 $(wildcard *.pdf) |head -1)
else
  SHOWPDF = @echo "no pdf files"
endif

PASSWORD  = cy.net

CLSUFFIX  = aux log snm toc vrb out out.bak dvi nav

all:
	@echo "Use the following command:"
	@echo "    make [0-8]"
	@echo "    make encrypt"
	@echo "    make cpdf|clean|cleanall"

$(PDFTARGT): %.pdf: %.tex preamble.tex author.tex
	-@gbk2uni -s $(basename $@) ; pdflatex $<

encrypt: $(foreach x,$(wildcard part-*.pdf),en-$(x))

en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

cleanall: cpdf clean

cpdf:;  -rm -f $(wildcard en-part-*.pdf part-*.pdf test.pdf z_region.pdf)

clean:; -rm -f $(foreach s,$(CLSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe z_region.*) 

ci:;    svn commit . -m "$(AUTOCSTR)"

ps:
	svn ps svn:eol-style CRLF auto/*.el pgf/auto/*.el
	svn ps svn:keywords Rev $(TXTFILES)
	svn ps Author $(Author) $(TXTFILES) $(BINFILES)
	svn ps Copyright $(Copyright) $(TXTFILES) $(BINFILES)

s:; $(SHOWPDF)

$(NUMTARGT): %: part-0%.pdf

.PHONY: all ci clean cleanall cpdf encrypt ps s $(shell seq 0 8)

.SUFFIXES: .tex .pdf

include .mk.dep
