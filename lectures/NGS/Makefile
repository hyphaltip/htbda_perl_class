MARKDOWN=pandoc --from markdown --to html5 --standalone --indented-code-classes=perl
LANDSLIDE=landslide
FLAGS=-t ../themes/luckywhite -r -i
all: $(patsubst %.slides.md,%.slides.html,$(wildcard *.slides.md)) $(patsubst %.table.md,%.table.html,$(wildcard *.table.md)) Makefile

%.table.html: %.table.md
	$(MARKDOWN) $< --output $@



%.slides.html: %.slides.md
	$(LANDSLIDE) $(FLAGS) $< -d $@

#%.pdf: %.md
#	$(LANDSLIDE) -t ../themes/luckywhite $< -d $@

clean:
	rm -f *.html
