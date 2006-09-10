## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$

Author="Chunyu Wang <chunyu@hit.edu.cn>"
Copyright="Copyright (C) 2006 Chunyu Wang."
PASSWORD=cy.net

AUTOCSTR=Batch checkin by Makefile ($(shell gdate "+%Y%m%d-%H:%M"))
TXTFILES=Makefile *.tex pgf/*.tex pgf/auto/*.el Outline.org auto/*.el code/*.cs logo/Makefile logo/*.mp figures/*.txt
BINFILES=figures/*.jpg figures/*.png figures/*.pdf figures/*.ppt
#OUTPUT=-output-directory=out

CLSUFFIX=aux log snm toc vrb out out.bak dvi nav

all:
	@echo "Do nothing, except the following:"
	@echo "  make [0-8]"
	@echo "  make encrypt"
	@echo "  make cpdf|clean|cleanall"

%.pdf: %.tex preamble.tex $(wildcard pgf/*.tex)
	-@gbk2uni -s $(basename $@)
	pdflatex $(OUTPUT) $<

encrypt: $(foreach s,$(wildcard part-*.pdf),en-$(s))
en-%.pdf: %.pdf
	pdftk $< output $@ owner_pw $(PASSWORD) allow printing
ci:
	svn commit . -m "$(AUTOCSTR)"

cleanall: cpdf clean
cpdf:
	-rm -f $(wildcard en-part-*.pdf part-*.pdf test.pdf z_region.pdf)
clean: 
	-rm -f $(foreach s,$(CLSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe z_region.*) 
ps:
	svn ps svn:eol-style CRLF auto/*.el pgf/auto/*.el
	svn ps svn:keywords Rev $(TXTFILES)
	svn ps Author $(Author) $(TXTFILES) $(BINFILES)
	svn ps Copyright $(Copyright) $(TXTFILES) $(BINFILES)

.PHONY: all ci clean cleanall cleanpdf encrypt ps $(shell seq 0 8)
.SUFFIXES: .tex .pdf

part-00.pdf: dn-intro.tex
part-01.pdf: dn-devel.tex dn-outline.tex
part-02.pdf: cs-basic.tex cs-class.tex
part-03.pdf: cs-advac.tex cs-other.tex
part-04.pdf: $(wildcard lib-*.tex)
part-05.pdf: 
part-06.pdf: 
part-07.pdf: 
part-08.pdf: 

0: part-00.pdf
1: part-01.pdf
2: part-02.pdf
3: part-03.pdf
4: part-04.pdf
5: part-05.pdf
6: part-06.pdf
7: part-07.pdf
8: part-08.pdf
t: test.pdf
