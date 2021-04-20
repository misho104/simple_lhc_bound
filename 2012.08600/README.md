# CMS 2012.08600

Search for two SFOS leptons and mPT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**CMS** Collaboration, `CMS-SUS-20-001`

- <http://cms-results.web.cern.ch/cms-results/public-results/publications/SUS-20-001/>
- Journal:
  [arXiv:2012.08600](https://arxiv.org/abs/2012.08600),
  [JHEP **2104** (2021) 125](http://doi.org/10.1007/JHEP04(2021)123)
- Data source: <http://cms-results.web.cern.ch/cms-results/public-results/publications/SUS-20-001/>, available as `root` files without explicit license. 

## Copyright

- Copyright 2020 CERN
- Copyright 2021 Sho Iwamoto

## Usage

The CMS data files are not attached.
To prepare the files, one needs `wget` or `curl` to download their `root` files and also needs `PyROOT` extension of `python` to convert the `root` files to `csv` files.

If those prerequisites are met, one can done the preparation by executing `make` in this directory; several `csv` files should be prepared `data` and those are read from Mathematica:

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2012.08600"]
LHCBoundUsage["2012.08600-ll"]
LHCBound["2012.08600-ll"][300, 50]
```

## Citation guide

```bibtex
@article{Sirunyan:2020eab,
    author = "Sirunyan, Albert M and others",
    collaboration = "CMS",
    title = "{Search for supersymmetry in final states with two oppositely charged same-flavor leptons and missing transverse momentum in proton-proton collisions at $\sqrt{s} =$ 13 TeV}",
    eprint = "2012.08600",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CMS-SUS-20-001, CERN-EP-2020-231",
    doi = "10.1007/JHEP04(2021)123",
    journal = "JHEP",
    volume = "2104",
    pages = "123",
    year = "2021"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
