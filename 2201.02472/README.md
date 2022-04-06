# ATLAS 2201.02472

Search for long-lived charginos based on a disappearing-track signature using 136 fb$^{-1}$ of pp collisions at $\sqrt{s}$ = 13TeV with the ATLAS detector 

**ATLAS** Collaboration, `SUSY-2018-19`

- <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/>
- Journal:
  [arXiv:2201.02472](https://arxiv.org/abs/2201.02472)
- Data source: <https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/>

This program utilizes Method 1 of the [Auxiliary Note](https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/hepdata_info.pdf),
namely its Figure 2 and 4, for reinterpretation.

The bounds calculated by this program is too strict compared to the original paper.
The difference amounts to 30–40% in the cross section, or 10–50 GeV in the chargino mass.
See `validation.wl`.

## Copyright

- Copyright 2022 CERN
- Copyright 2022 Sho Iwamoto

## Usage

```mathematica
AppendTo[$Path, (path to SimpleLHCBound.m)];
<<SimpleLHCBound`;
LHCBoundInfo["2201.02472"]
LHCBoundUsage["2201.02472-Wino"]
LHCBound["2201.02472-Wino"][10^-9, 200]
```

## Citation guide

```bibtex
@article{ATLAS:2022rme,
    author = "Aad, Georges and others",
    collaboration = "ATLAS",
    title = "{Search for long-lived charginos based on a disappearing-track signature using 136 fb$^{-1}$ of $pp$ collisions at $\sqrt{s}$ = 13 TeV with the ATLAS detector}",
    eprint = "2201.02472",
    archivePrefix = "arXiv",
    primaryClass = "hep-ex",
    reportNumber = "CERN-EP-2021-209",
    month = "1",
    year = "2022",
    note = "Data set is available on \href{https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/}{ATLAS website}"
}
@misc{simplelhc,
    author = "Sho Iwamoto",
    title = "Simple LHC bound",
    url = "https://github.com/misho104/simple_lhc_bound"
}
```
