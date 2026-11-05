.PHONY: all clean

all:
	xelatex --shell-escape main.tex

clean:
	rm -f main.aux main.log main.out main.pdf main.toc main.xdv main.synctex.gz
	rm -rf svg-inkscape
