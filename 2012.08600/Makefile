.PHONY: all dev clean

include ../Makefile.config

XS = $(addsuffix .xs,\
    13TeV.gg.decoup 13TeV.n2x1+-.wino 13TeV.sb10.decoup 13TeV.slepslep \
)

DATA_DIR = data
URL_PREFIX = http://cms-results.web.cern.ch/cms-results/public-results/publications/SUS-20-001/CMS-SUS-20-001_
ROOT_DATA = Figure_010.root Figure_011.root Figure_013-a.root Figure_013-b.root Figure_014.root
CSV_DATA = $(addprefix $(DATA_DIR)/,$(ROOT_DATA:.root=.csv))

ifeq ($(PYROOT),0)
  $(warning 2012.08600 skipped PyROOT is missing.)
  XS =
  ROOT_DATA =
  CSV_DATA =
endif


# prepare constraint data
all: $(CSV_DATA)

# prepare susy-xs data
dev: all $(XS)

clean:
	@$(RM) $(DATA_DIR)/*.csv $(DATA_DIR)/*.root *.xs


$(addprefix $(DATA_DIR)/,$(ROOT_DATA)):
	$(WGET) $@ $(URL_PREFIX)$(notdir $@)

%.csv : %.root
	python3 ../cms_root_parse.py $< "ul_histo" > $@

$(XS): %.xs :
	susy-xs export --format Math --no-unc $* > $@
