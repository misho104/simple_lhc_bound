.PHONY: all dev

XS = $(addsuffix .xs,\
		13TeV.n2x1+-.wino 13TeV.x1x1.wino 13TeV.n2x1+-.hino.deg 13TeV.x1x1.hino.deg \
)

all:
	@:  #nothing to do

# prepare susy-xs data
dev: $(XS)

clean:
	@$(RM) *.xs


$(XS): %.xs :
	susy-xs export --format Math --no-unc $* > $@
