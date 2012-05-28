all: paper.pdf

.PHONY: paper.pdf

paper.pdf: refs.bbl
	pdflatex -halt-on-error paper.tex

refs.bbl: refs.bib paper.aux
	bibtex paper

paper.aux: paper.tex
	pdflatex -halt-on-error $<

watch: all
	# This requires watchr.  Install it with e.g.
	#
	#   gem install watchr --user
	#
	# see: https://github.com/mynyml/watchr
	watchr -e "watch('paper.tex') {system 'make'};"

clean:
	-rm -f paper.aux paper.log paper.pdf paper.bbl paper.blg
