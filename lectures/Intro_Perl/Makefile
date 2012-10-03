
LANDSLIDE=landslide
FLAGS=-t ../themes/luckywhite -r 

all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

pdf: $(patsubst %.md,%.pdf,$(wildcard *.md)) Makefile
%.html: %.md
	$(LANDSLIDE) $(FLAGS) $< -d $@

%.pdf: %.md
	$(LANDSLIDE) $< -d $@

clean:
	rm -f *.html *.pdf


