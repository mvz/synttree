test.dvi: test.tex synttree.sty
	latex $<

synttree.sty: synttree.ins synttree.dtx
	rm -f $@
	tex $<

synttree.dvi: synttree.dtx synttree.sty
	latex $<
	latex $<

synttree.pdf: synttree.dvi
	dvipdfm $^

synttree.tar.gz: synttree.dtx synttree.ins README synttree.pdf readme.txt
	tar cvzf $@ $^

simple.dvi balance.dvi tree.dvi : %.dvi : %.tex
	latex $<

.PHONY: package clean doc all

package: synttree.tar.gz

clean:
	rm -f *.aux *.log *.dvi *.toc *.sty *.glo *.idx *.ilg *.ind

doc: 	synttree.dvi

all:	doc test.dvi
