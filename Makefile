.PHONY: paper.pdf

paper.pdf: paper.tex
	pdflatex -halt-on-error $<

watch:
	# This requires watchr.  Install it with e.g.
	#
	#   gem install watchr --user
	#
	# see: https://github.com/mynyml/watchr
	watchr -e "watch('paper.tex') {system 'make'};"

clean:
	-rm -f paper.aux paper.log paper.pdf
