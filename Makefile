.PHONY: default debug clean clean-default clean-debug purge

NAME = project
TEMPLATE_DIR = template
TEX_FILE = index.tex

##########

default:
	mkdir -p target/default/src target/default/chapters
	TEXINPUTS=$(TEXINPUTS):./$(TEMPLATE_DIR) latexmk -lualatex -jobname=$(NAME) -output-directory=target/default -quiet $(TEX_FILE)
	cp target/default/$(NAME).pdf target

debug: clean-debug
	mkdir -p target/debug/src   target/debug/chapters
	TEXINPUTS=$(TEXINPUTS):./$(TEMPLATE_DIR) latexmk -lualatex -jobname=debug -output-directory=target/debug            $(TEX_FILE)
	cp target/debug/debug.pdf target/debug.pdf

clean: clean-default clean-debug
	$(RM) -r target

clean-default:
	$(RM) -r target/default

clean-debug:
	$(RM) -r target/debug

purge:
	$(RM) -r target
