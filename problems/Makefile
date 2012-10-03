MARKDOWN=pandoc --from markdown --to html5 --standalone --indented-code-classes=perl

all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

%.html: %.md
	$(MARKDOWN) $< --output $@
