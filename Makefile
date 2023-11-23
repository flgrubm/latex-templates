#### CUSTOMIZATION

# leave blank if not applicable
NAME = project
MAIN_TEX = index.tex
BIB_FILE =
TEMPLATE_DIR = template
ADDITIONAL_SOURCES =

# choose from `lualatex` and `xelatex`
DEFAULT = xelatex
RELEASE = lualatex


#### INTERNAL

VERSIONS = xelatex lualatex debug-xelatex debug-lualatex
export COMPILER =
export DEBUG =

.PHONY: default release $(VERSIONS) $(foreach version,$(VERSIONS),clean-$(version)) clean-default clean-release $(foreach version,$(VERSIONS),clean-pdf-$(version)) clean-pdf-default clean-pdf-release clean purge

## COMPILATION

default: $(DEFAULT)
	mv target/$(DEFAULT).pdf target/default.pdf

release: clean-release clean-pdf-release | $(RELEASE)
	mv target/$(RELEASE).pdf target/$(NAME).pdf

xelatex: COMPILER = xelatex
lualatex: COMPILER = lualatex

debug-xelatex: COMPILER = xelatex
debug-xelatex: DEBUG = 1
debug-lualatex: COMPILER = lualatex
debug-lualatex: DEBUG = 1

$(foreach version,$(VERSIONS),target/$(version).pdf): target/%.pdf: target/%/out.pdf
	cp -f $< $@

$(foreach version,$(VERSIONS),target/$(version)/out.pdf): target/%/out.pdf: target/% $(MAIN_TEX) $(BIB_FILE) $(ADDITIONAL_SOURCES) $(TEMPLATE_DIR) $(if $(TEMPLATE_DIR),latexmkrc,)
	latexmk -$(COMPILER) -$(if $(DEBUG),gg,quiet) -jobname=out -output-directory=target/$* $(MAIN_TEX)

$(foreach version,$(VERSIONS),target/$(version)):
	mkdir -p $@

$(foreach version,$(VERSIONS),$(version)): %: target/%.pdf

## LATEXMK CONFIGURATION

# add TEMPLATE_DIR to path if it exists
LATEXMKRC_CONTENT = $(if $(TEMPLATE_DIR),"\$$ENV{'TEXINPUTS'}='./$(TEMPLATE_DIR):' . \$$ENV{'TEXINPUTS'};",)

latexmkrc:
	echo $(LATEXMKRC_CONTENT) > latexmkrc

## CLEAN

$(foreach version,$(VERSIONS),clean-$(version)): clean-%:
	$(RM) -r target/$*

clean-default: clean-$(DEFAULT)
clean-release: clean-$(RELEASE)

$(foreach version,$(VERSIONS),clean-pdf-$(version)): clean-pdf-%:
	$(RM) -r target/$*.pdf

clean-pdf-default:
	$(RM) target/default.pdf

clean-pdf-release:
	$(RM) target/$(NAME).pdf

clean: $(foreach version,$(VERSIONS),clean-$(version))

purge: clean
	$(RM) -r target
	$(RM) latexmkrc
