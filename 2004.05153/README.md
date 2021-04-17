# CMS 2014.05153

Search for disappearing tracks in proton-proton collisions at
$\sqrt{s}$ = 13TeV

**CMS** Collaboration, `CMS-EXO-19-010`

- <http://cms-results.web.cern.ch/cms-results/public-results/publications/EXO-19-010/>
- Journal:
  [arXiv:2004.05153](https://arxiv.org/abs/2004.05153),
  [Phys. Lett. B 806 (2020) 135502](http://dx.doi.org/10.1016/j.physletb.2020.135502)
- Data source: <https://www.hepdata.net/record/ins1790827>
- Data source DOI: <https://doi.org/10.17182/hepdata.95354.v2>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2021 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2004.05153"]
LHCBoundUsage["2004.05153-Wino"]
LHCBound["2004.05153-Wino"][10^-9, 200]
```

## Citation guide

```bibtex
@article{Sirunyan:2020pjd,
    collaboration = "CMS",
    title = "{Search for disappearing tracks in proton-proton collisions at $\sqrt{s} =$ 13 TeV}",
    eprint = "2004.05153",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CMS-EXO-19-010, CERN-EP-2020-043",
    doi = "10.1016/j.physletb.2020.135502",
    journal = "Phys. Lett. B",
    volume = "806",
    pages = "135502",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.95354.v2}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
