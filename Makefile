## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>

LESSONS = lesson-01

all:
	for i in $(LESSONS) ; do \
	  if [ -e $$i.out ] ; then  gbk2uni $$i ; fi ; \
	  pdflatex $$i ; \
	done

clean: distclean

distclean:
	rm -fv *.nav *.log *.snm *.toc *.out *.aux *.vrb *.out.bak *.pdf

.PHONY:	all clean distclean
