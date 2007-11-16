## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn> ##

Author    = "Chunyu Wang <chunyu@hit.edu.cn>"
Copyright = "Copyright (C) 2006-2007 Chunyu Wang."

PRGFILES  = Makefile auto/*.el
TXTFILES  = {.,pgf}/*.tex $(PRGFILES) Outline.org code/*.cs figures/*.txt .dired 
BINFILES  = figures/*.{jpg,png,pdf} res/*.7z

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
	@echo "    make cpdf | clean | cleanall | distclean"
	@echo "    make ci | st | ps | rar | 7z"

$(NUMTARGT): %: part-0%.pdf

$(PDFTARGT): %.pdf: %.tex preamble.tex author.tex ; -@gbk2uni -s $(basename $@) ; pdflatex $<

encrypt: $(foreach x,$(wildcard part-*.pdf),en-$(x))

en-%.pdf: %.pdf ; pdftk $< output $@ owner_pw $(PASSWORD) allow printing

distclean: cleanall tclean

cleanall: cpdf clean

cpdf:;  -$(RM) $(wildcard en-part-*.pdf part-*.pdf test.pdf z_region.pdf)

clean:; -$(RM) $(foreach s,$(CLSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe */z_region*)

tclean:; -$(RM) -rf $(foreach s,test z_region,$(wildcard $(s).* */$(s).*))

st:;    @svn st .

ci:;    svn commit . -m "$(AUTOCSTR)"

ps:
	svn ps svn:eol-style CRLF auto/*.el
	svn ps Author $(Author) $(TXTFILES) $(BINFILES)
	svn ps Copyright $(Copyright) $(TXTFILES) $(BINFILES)
#svn ps svn:keywords Rev $(TXTFILES)

s:; $(SHOWPDF)

rar:; winrar -m5 a dotnet.rar $(CURRPDF)
7z:;  7z    -mx9 a dotnet.7z  $(CURRPDF)

.PHONY: all ci clean cleanall cpdf encrypt ps s st $(shell seq 0 8)  $(SUBDIRS)

.SUFFIXES: .tex .pdf .dvi .ps .eps .jpg .png

part-00.pdf: dn-intro.tex
part-01.pdf: $(wildcard  dn-*.tex pgf/*.tex)
part-02.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
part-03.pdf: $(wildcard  cs-*.tex pgf/cs-*.tex)
part-04.pdf: $(wildcard lib-*.tex pgf/lib-*.tex)
part-05.pdf: $(wildcard ado-*.tex pgf/ado-*.tex)
part-06.pdf: $(wildcard asp-*.tex pgf/asp-*.tex)
part-07.pdf: 
part-08.pdf: $(wildcard *.tex pgf/*.tex)

# Local Variables:
# mode: makefile-gmake
# End:
