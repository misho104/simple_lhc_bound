# ATLAS 2106.01676

Search for three-lepton and mPT in proton-proton collisions at $\sqrt{s}$ = 13TeV

**ATLAS** Collaboration, `SUSY-2019-09`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/>
- Journal:
  [arXiv:2106.01676](https://arxiv.org/abs/2106.01676),
  [Eur. Phys. J. **C81** (2021) 1118](https://doi.org/10.1140/epjc/s10052-021-09749-7)
- Data source: <https://www.hepdata.net/record/ins1866951>
- Data source DOI: <https://doi.org/10.17182/hepdata.95751>
- Data license: [CC0](https://creativecommons.org/cc0) (`HEPData-*.csv`) and [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/legalcode) (`tabaux_*.csv`)

## Copyright

- Copyright 2021 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2106.01676"]
LHCBoundUsage["2106.01676-WinoOppo/WZ"]
LHCBound["2106.01676-WinoOppo/WZ"][200, 182]
```

## Citation guide

```bibtex
@article{ATLAS:2021moa,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for chargino\textendash{}neutralino pair production in final states with three leptons and missing transverse momentum in $\sqrt{s} = 13$~TeV pp collisions with the ATLAS detector}",
    eprint = "2106.01676",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2021-059",
    doi = "10.1140/epjc/s10052-021-09749-7",
    journal = "Eur. Phys. J. C",
    volume = "81",
    number = "12",
    pages = "1118",
    year = "2021",
    note = "Data set is available on \href{https://doi.org/10.17182/hepdata.95751}{HEPData}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
