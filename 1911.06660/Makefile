.PHONY: all dev clean

include ../Makefile.config

XS = $(addsuffix .xs,\
    13TeV.slepslep 13TeV.slepslep.ll 13TeV.slepslep.rr \
)

all:
	@:  #nothing to do

# prepare susy-xs data
dev: all $(XS)

clean:
	@$(RM) *.xs

$(XS): %.xs :
	susy-xs export --format Math --no-unc $* > $@
