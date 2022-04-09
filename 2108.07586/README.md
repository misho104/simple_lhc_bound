# ATLAS 2108.07586

Search for electroweakinos in two boosted hadronically-decaying boson and mPT at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2018-41`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/>
- Journal:
  [arXiv:2108.07586](https://arxiv.org/abs/2108.07586),
  [Phys. Rev. **D 104** (2021) 112010](http://doi.org/10.1103/PhysRevD.104.112010)
- Data source: <https://www.hepdata.net/record/ins1906174>
- Data source DOI: <https://doi.org/10.17182/hepdata.104458.v1>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2021 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2108.07586"]
LHCBoundUsage["2108.07586-CN/WH"]
LHCBound["2108.07586-CN/WH"][800, 100]
```

## Citation guide

```bibtex
@article{ATLAS:2021yqv,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for charginos and neutralinos in final states with two boosted hadronically decaying bosons and missing transverse momentum in $pp$ collisions at $\sqrt {s}$ = 13\,TeV with the ATLAS detector}",
    eprint = "2108.07586",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2021-127",
    doi = "10.1103/PhysRevD.104.112010",
    journal = "Phys. Rev. D",
    volume = "104",
    number = "11",
    pages = "112010",
    year = "2021",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.104458.v1}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
