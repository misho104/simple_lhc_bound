# ATLAS 2004.10894

Search for a Higgs boson accompanied with leptons, jets, or mPT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2018-23`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-23/>
- Journal:
  [arXiv:2004.10894](https://arxiv.org/abs/2004.10894),
  [JHEP **2010** (2020) 005](https://doi.org/10.1007/JHEP10(2020)005)
- Data source: <https://www.hepdata.net/record/ins1792399>
- Data source DOI: <https://doi.org/10.17182/hepdata.90017>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2004.10894"]
LHCBoundUsage["2004.10894-CN/WH"]
LHCBound["2004.10894-CN/WH"][300, 50]
```

## Citation guide

```bibtex
@article{ATLAS:2020qlk,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for direct production of electroweakinos in final states with missing transverse momentum and a Higgs boson decaying into photons in pp collisions at $ \sqrt{s} $ = 13 TeV with the ATLAS detector}",
    eprint = "2004.10894",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2019-204",
    doi = "10.1007/JHEP10(2020)005",
    journal = "JHEP",
    volume = "10",
    pages = "005",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.90017}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
