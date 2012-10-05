
LANDSLIDE=landslide
FLAGS=-t ../themes/luckywhite -r -i

all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

pdf: $(patsubst %.md,%.pdf,$(wildcard *.md)) Makefile

%.html: %.md
	$(LANDSLIDE) $(FLAGS) $< -d $@

%.pdf: %.md
	$(LANDSLIDE) -t ../themes/luckywhite $< -d $@

clean:
	rm -f *.html *.pdf


