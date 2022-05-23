.PHONY: all dev clean validation

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

validation: dev
	echo 'Get["validation.wl"]' | $(WOLFRAM)
