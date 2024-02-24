#### CUSTOMIZATION

# leave blank if not applicable
NAME = project
MAIN_TEX = index.tex
BIB_FILE =
TEMPLATE_DIR = template
INCLUDE_DIRS = chapters
ADDITIONAL_SOURCES =

# choose from `lualatex` and `xelatex`
COMPILER_DEFAULT = xelatex
COMPILER_RELEASE = lualatex
COMPILER_DEBUG   = xelatex


#### INTERNAL
# proceed at your own risk

## Constants

COMPILE_MODES = default debug
COMPILERS     = xelatex lualatex
SVERSIONS     = $(foreach mode,$(COMPILE_MODES),$(foreach compiler,$(COMPILERS),$(mode)-$(compiler)))
NVERSIONS     = default debug $(SVERSIONS)
VERSIONS      = release $(NVERSIONS)

ifdef TEMPLATE_DIR
    TEMPLATE_SOURCES =  $(wildcard $(TEMPLATE_DIR)/*.cls)
    TEMPLATE_SOURCES += $(wildcard $(TEMPLATE_DIR)/*.sty)
endif

INCLUDE_DIR_SOURCES = $(foreach dir,$(INCLUDE_DIRS),$(wildcard $(dir)/*.tex))
SOURCES             = $(MAIN_TEX) $(BIB_FILE) $(LATEXMKRC) $(TEMPLATE_SOURCES) $(INCLUDE_DIR_SOURCES) $(ADDITIONAL_SOURCES)

ifdef TEMPLATE_SOURCES
    LATEXMKRC = latexmkrc
endif

LATEXMKRC_CONTENT = $(if $(TEMPLATE_DIR),"\$$ENV{'TEXINPUTS'}='./$(TEMPLATE_DIR):' . \$$ENV{'TEXINPUTS'};",)

## Initialization

.PHONY: $(VERSIONS) xelatex lualatex $(foreach version,$(VERSIONS),clean-$(version)) $(foreach version,$(VERSIONS),cleanpdf-$(version)) clean cleanpdf purge

## Main build target initialization

default: COMPILER = $(COMPILER_DEFAULT)
release: COMPILER = $(COMPILER_RELEASE)
debug:   COMPILER = $(COMPILER_DEBUG)

default: target/default.pdf

release: clean-release cleanpdf-release | target/$(NAME).pdf
target/$(NAME).pdf: target/release.pdf
	mv $< $@

debug: DEBUG = 1
debug: clean-debug cleanpdf-debug | target/debug.pdf

$(foreach mode,$(COMPILE_MODES),$(mode)-xelatex): COMPILER = xelatex
$(foreach mode,$(COMPILE_MODES),$(mode)-lualatex): COMPILER = lualatex
$(foreach compiler,$(COMPILERS),debug-$(compiler)): DEBUG = 1

$(foreach sversion,$(SVERSIONS),$(sversion)): %: target/%.pdf

xelatex:  default-xelatex
lualatex: default-lualatex

## Compilation

$(foreach version,$(VERSIONS),target/$(version)):
	mkdir -p $@

$(foreach version,$(VERSIONS),$(foreach dir,$(INCLUDE_DIRS),target/$(version)/$(dir))):
	mkdir -p $@

$(foreach version,$(VERSIONS),target/$(version).pdf): target/%.pdf: target/%/out.pdf
	cp -f $< $@

$(foreach version,$(VERSIONS),target/$(version)/out.pdf): %/out.pdf: % $(foreach dir,$(INCLUDE_DIRS),%/$(dir)) $(SOURCES)
	latexmk -$(COMPILER) -$(if $(DEBUG),gg,quiet) -jobname=out -output-directory=$* $(MAIN_TEX)

## latexmkrc

latexmkrc:
	echo $(LATEXMKRC_CONTENT) > latexmkrc

## Cleanup

$(foreach version,$(VERSIONS),clean-$(version)): clean-%:
	$(RM) -r target/$*

$(foreach version,$(NVERSIONS),cleanpdf-$(version)): cleanpdf-%:
	$(RM) target/$*.pdf

cleanpdf-release:
	$(RM) target/$(NAME).pdf

clean: $(foreach version,$(VERSIONS),clean-$(version))

cleanpdf: $(foreach version,$(VERSIONS),cleanpdf-$(version))

purge: clean
	$(RM) -r target
	$(RM) latexmkrc
