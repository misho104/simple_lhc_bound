# ATLAS 1909.09226

Search for one lepton, bb, and mPT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2019-08`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-08/>
- Journal:
  [arXiv:1909.09226](https://arxiv.org/abs/1909.09226),
  [Eur. Phys. J. **C80** (2020) 691](https://doi.org/10.1140/epjc/s10052-020-8050-3)
- Data source: <https://www.hepdata.net/record/ins1755298>
- Data source DOI: <https://doi.org/10.17182/hepdata.90607.v4>
- Data license: [CC0](https://creativecommons.org/cc0)

## Copyright

- Copyright 2020 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["1909.09226"]
LHCBoundUsage["1909.09226-CN/WH"]
LHCBound["1909.09226-CN/WH"][600, 100]
```

## Citation guide

```bibtex
@article{ATLAS:2020pgy,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for direct production of electroweakinos in final states with one lepton, missing transverse momentum and a Higgs boson decaying into two $b$-jets in $pp$ collisions at $\sqrt{s}=13$ TeV with the ATLAS detector}",
    eprint = "1909.09226",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2019-188",
    doi = "10.1140/epjc/s10052-020-8050-3",
    journal = "Eur. Phys. J. C",
    volume = "80",
    number = "8",
    pages = "691",
    year = "2020",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.90607.v4}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
