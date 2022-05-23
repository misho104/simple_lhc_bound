# ATLAS 1912.08479

Search for three leptons and mPT (and an ISR jet) in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2018-06`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-06/>
- Journal:
  [arXiv:1912.08479](https://arxiv.org/abs/1912.08479),
  [Phys. Rev. **D101** (2020) 072001](https://doi.org/10.1103/PhysRevD.101.072001)
- Data source: <https://www.hepdata.net/record/ins1771533>
- Data source DOI: <https://doi.org/10.17182/hepdata.91127.v2>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["1912.08479"]
LHCBoundUsage["1912.08479-CN/WZ"]
LHCBound["1912.08479-CN/WZ"][200, 100]
```

## Citation guide

```bibtex
@article{ATLAS:2019wgx,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for chargino-neutralino production with mass splittings near the electroweak scale in three-lepton final states in $\sqrt {s}$=13  TeV $pp$ collisions with the ATLAS detector}",
    eprint = "1912.08479",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2019-263",
    doi = "10.1103/PhysRevD.101.072001",
    journal = "Phys. Rev. D",
    volume = "101",
    number = "7",
    pages = "072001",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.91127.v2}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
