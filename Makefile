## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>

LESSONS = lesson-01 lesson-02

all: $(LESSONS)
# 	for i in $(LESSONS) ; do \
# 	  if [ -e $$i.out ] ; then  gbk2uni $$i ; fi ; \
# 	  pdflatex $$i ; \
# 	done

lesson-%:
	if [ -e $@.out ] ; then  gbk2uni $@ ; fi ; 
	pdflatex $@ ; 

clean: distclean

distclean:
	rm -fv *.nav *.log *.snm *.toc *.out *.aux *.vrb *.out.bak *.pdf

.PHONY:	all clean distclean
