## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) 2006 Chunyu Wang."
PASSWORD  = cy.net

AUTOCSTR  = Batch checkin by Makefile ($(shell gdate "+%Y%m%d-%H:%M"))
TXTFILES  = Makefile *.tex pgf/*.tex pgf/auto/*.el Outline.org auto/*.el code/*.cs logo/Makefile logo/*.mp figures/*.txt
BINFILES  = figures/*.jpg figures/*.png figures/*.pdf figures/*.ppt
#OUTPUT   = -output-directory=out

CLSUFFIX  = aux log snm toc vrb out out.bak dvi nav

NUMTARGT  = $(shell seq 0 8)
PDFTARGT  = $(NUMTARGT:%=part-0%.pdf)

all:
	@echo "Use the following command:"
	@echo "    make [0-8]"
	@echo "    make encrypt"
	@echo "    make cpdf|clean|cleanall"

$(PDFTARGT): %.pdf: %.tex preamble.tex author.tex
	-@gbk2uni -s $(basename $@) ; pdflatex $(OUTPUT) $<

encrypt: $(foreach s,$(wildcard part-*.pdf),en-$(s))

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

s: $(shell ls -t -1 *.pdf |head -1) ; start $^

$(NUMTARGT): %: part-0%.pdf

.PHONY: all ci clean cleanall cpdf encrypt ps s $(shell seq 0 8)

.SUFFIXES: .tex .pdf

include .mk.dep
