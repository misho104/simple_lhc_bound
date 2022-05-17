.PHONY: all dev clean

include ../Makefile.config

XS = $(addsuffix .xs,\
	13TeV.n2x1+-.wino \
)

all:
	@:  #nothing to do

# prepare susy-xs data
dev: all $(XS)

clean:
	@$(RM) *.xs

$(XS): %.xs :
	susy-xs export --format Math --no-unc $* > $@
