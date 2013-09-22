PANDOC=pandoc --columns=80  -s --mathjax --slide-level=2  
SLIDY=$(PANDOC) -t slidy
LANDSLIDE=landslide
#SLIDES=$(PANDOC) --highlight-style tango --css=slides.css -w dzslides 
FLAGS=-t ../themes/luckywhite -r -i --math-output 
SLIDES=$(LANDSLIDE) $(FLAGS)
HANDOUT=$(PANDOC) --highlight-style tango --css=text.css -w html5 

####################################################################

# clear out all suffixes
.SUFFIXES:
# list only those we use
.SUFFIXES: .html .md

all: slides handout pdf

slides: $(patsubst %.md,%.slides.html,$(wildcard *.md))

handout: $(patsubst %.md,%.handout.html,$(wildcard *.md))

pdf: $(patsubst %.md,%.pdf,$(wildcard *.md))


%.slides.html: %.md
	$(SLIDES) $< -d $@


%.handout.html: %.md
	$(HANDOUT) $< -o $@


%.pdf: %.md
	$(LANDSLIDE) $< -d $@
#	$(PANDOC) $< -o $@


clean:
	rm -f *.pdf *.html *.class
