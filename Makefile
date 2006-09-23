## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn> ## $Rev$

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) 2006 Chunyu Wang."

PRGFILES  = {.,logo}/Makefile .mk.dep auto/*.el logo/*.mp
TXTFILES  = {.,pgf,res}/*.tex $(PRGFILES) Outline.org {code,lab}/*.cs {figures,res}/*.txt .dired 
BINFILES  = figures/*.{jpg,png,pdf,ppt} logo/*.jpg lab/*.{doc,pdf} res/*.doc

NUMTARGT  = $(shell seq 0 8)
PDFTARGT  = $(NUMTARGT:%=part-0%.pdf)

AUTOCSTR  = Batch checkin by Makefile ($(shell $(DATE) "+%Y-%m-%d %H:%M") on $(shell uname -n))
ifeq ($(shell uname -s),"windows32") 
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

all:
	@echo "Usage:"
	@echo "    make [0-8] | s | encrypt"
	@echo "    make cpdf | clean | cleanall"
	@echo "    make ci | st | ps | rar | 7z"

$(NUMTARGT): %: part-0%.pdf
$(PDFTARGT): %.pdf: %.tex preamble.tex author.tex
	-@gbk2uni -s $(basename $@) ; pdflatex $<

encrypt: $(foreach x,$(wildcard part-*.pdf),en-$(x))

en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

cleanall: cpdf clean

cpdf:;  -$(RM) $(wildcard en-part-*.pdf part-*.pdf test.pdf z_region.pdf)

clean:; -$(RM) $(foreach s,$(CLSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe */z_region*)

st:;    @svn st .

ci:;    svn commit . -m "$(AUTOCSTR)"

ps:
	svn ps svn:eol-style CRLF auto/*.el
	svn ps svn:keywords Rev $(TXTFILES)
	svn ps Author $(Author) $(TXTFILES) $(BINFILES)
	svn ps Copyright $(Copyright) $(TXTFILES) $(BINFILES)

s:; $(SHOWPDF)

rar:; winrar -m5 a dotnet.rar $(CURRPDF)
7z:;  7z -mx9 a dotnet.7z $(CURRPDF)

.PHONY: all ci clean cleanall cpdf encrypt ps s st $(shell seq 0 8)

.SUFFIXES: .tex .pdf .dvi .ps .eps .jpg .png

include .mk.dep

# Local Variables:
# mode: makefile-gmake
# End:
