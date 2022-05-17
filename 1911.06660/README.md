# ATLAS 1911.06660

Search for two hadronic taus and mpT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2018-04`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-04/>
- Journal:
  [arXiv:1911.06660](https://arxiv.org/abs/1911.06660),
  [Phys. Rev. **D101** (2020) 032009](https://doi.org/10.1103/PhysRevD.101.032009)
- Data source: <https://www.hepdata.net/record/ins1765529>
- Data source DOI: <10.17182/hepdata.92006.v2>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["1911.06660"]
LHCBoundUsage["1911.06660-CN/WH"]
LHCBound["1911.06660-CN/WH"][600, 100]
```

## Citation guide

```bibtex
@article{ATLAS:2019gti,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for direct stau production in events with two hadronic $\tau$-leptons in $\sqrt{s} = 13$ TeV $pp$ collisions with the ATLAS detector}",
    eprint = "1911.06660",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2019-191",
    doi = "10.1103/PhysRevD.101.032009",
    journal = "Phys. Rev. D",
    volume = "101",
    number = "3",
    pages = "032009",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.92006.v2}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
