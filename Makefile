.PHONY: default debug clean clean-default clean-debug purge

NAME = project
TEX_FILE = index.tex
TEMPLATE_DIR = template

##########

LATEXMKRC_CONTENT = "\$$ENV{'TEXINPUTS'}='./$(TEMPLATE_DIR):' . \$$ENV{'TEXINPUTS'};"

default: latexmkrc
	mkdir -p target/default
	latexmk -lualatex -jobname=$(NAME) -output-directory=target/default -quiet $(TEX_FILE)
	cp target/default/$(NAME).pdf target

debug: clean-debug latexmkrc
	mkdir -p target/debug
	latexmk -lualatex -jobname=debug -output-directory=target/debug            $(TEX_FILE)
	cp target/debug/debug.pdf target/debug.pdf

latexmkrc:
	echo $(LATEXMKRC_CONTENT) > latexmkrc

clean: clean-default clean-debug

clean-default:
	$(RM) -r target/default

clean-debug:
	$(RM) -r target/debug

purge: clean
	$(RM) -r target
	$(RM) latexmkrc
