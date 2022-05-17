# ATLAS 1908.08215

Search for two SFOS/DFOS leptons and mPT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2018-32`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/>
- Journal:
  [arXiv:1908.08215](https://arxiv.org/abs/1908.08215),
  [Eur. Phys. J. **C80** (2020) 123](https://doi.org/10.1140/epjc/s10052-019-7594-6)
- Data source: <https://www.hepdata.net/record/ins1750597>
- Data source DOI: <https://doi.org/10.17182/hepdata.89413.v2>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2021 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["1908.08215"]
LHCBoundUsage["1908.08215-ll2LR"]
LHCBound["1908.08215-ll2LR"][300, 50]
```

## Citation guide

```bibtex
@article{Aad:2019vnb,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for electroweak production of charginos and sleptons decaying into final states with two leptons and missing transverse momentum in $\sqrt{s}=13$ TeV $pp$ collisions using the ATLAS detector}",
    eprint = "1908.08215",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2019-106",
    doi = "10.1140/epjc/s10052-019-7594-6",
    journal = "Eur. Phys. J. C",
    volume = "80",
    number = "2",
    pages = "123",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.89413.v2}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
