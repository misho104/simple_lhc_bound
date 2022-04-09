(* ::Package:: *)

(* Time-Stamp: <2022-04-09 20:30:31> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2108.07586"] = <|
  "info" -> <|
    "names"         -> {"2108.07586-CC/WW", "2108.07586-CN/WZ", "2108.07586-CN/WH", "2108.07586-HH/grav",
                        "2108.07586-Fig12-WB", "2108.07586-Fig12-HB", "2108.07586-Fig17"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "2108.07586",
    "summary"       -> "VV+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["2108.07586-CC/WW"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["HEPData-ins1906174-v1-csv/Observedcross-sectionupperlimitonC1C1-WW.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True]},
    (* {mC[GeV], mLSP[GeV], xs[pb]} should be converted to {mC[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2108.07586-CC/WW\"][m_chargino/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>];

BoundData["2108.07586-CN/WZ"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["HEPData-ins1906174-v1-csv/Observedcross-sectionupperlimitonC1N2-WZ.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True]},
    (* {mN[GeV], mLSP[GeV], xs[pb]} should be converted to {mN[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2108.07586-CN/WZ\"][m_C1N2/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb, assuming Br(N2 to Z+LSP) = 1."
|>];

BoundData["2108.07586-CN/WH"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["HEPData-ins1906174-v1-csv/Observedcross-sectionupperlimitonC1N2-WH.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True]},
    (* {mN[GeV], mLSP[GeV], xs[pb]} should be converted to {mN[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2108.07586-CN/WH\"][m_C1N2/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb, assuming Br(N2 to H+LSP) = 1."
|>];

BoundData["2108.07586-HH/grav"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["HEPData-ins1906174-v1-csv/Observedcross-sectionupperlimiton(H~,G~).csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True]},
    (* {mHiggsino[GeV], BrToZ[%], xs[pb]} should be converted to {mHiggsino[GeV], BrToZ, xs[fb]} *)
    {#[[1]], #[[2]]/100, #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2108.07586-HH/grav\"][m_Higgsino/GeV, Br(N1 to Z)] returns upper bounds on \[Sigma]/fb.\nHiggsinos (N1, N2, C1) are assumed degenerate and N1 is assumed to decay exclusively into (Z or H) + gravitino."
|>];

BoundData["2108.07586-Fig12-WB"] = IfDataFileExists[<|
  "table" -> {
      {0   , Import["HEPData-ins1906174-v1-csv/Obslimiton(W~,B~)B(N2->ZN1)=0%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
      {0.25, Import["HEPData-ins1906174-v1-csv/Obslimiton(W~,B~)B(N2->ZN1)=25%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
      {0.50, Import["HEPData-ins1906174-v1-csv/Obslimiton(W~,B~)B(N2->ZN1)=50%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
      {0.75, Import["HEPData-ins1906174-v1-csv/Obslimiton(W~,B~)B(N2->ZN1)=75%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
      {1.00, Import["HEPData-ins1906174-v1-csv/Obslimiton(W~,B~)B(N2->ZN1)=100%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line}},
    "usage" -> "LHCBoundTable[\"2108.07586-Fig12-WB\"] contains a table of {Br(N2->Z), Observed Exclusion Line}.\nThe line is on (Chargino[GeV], LSP[GeV])-plane."
  |>];

BoundData["2108.07586-Fig12-HB"] = IfDataFileExists[<|
  "table" -> {
      {0,    Get["data/HB-000.m"] // Line},
      {0.25, Get["data/HB-025.m"] // Line},
      {0.50, Import["HEPData-ins1906174-v1-csv/Obslimiton(H~,B~)B(N2->ZN1)=50%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
      {0.75, Get["data/HB-075.m"] // Line},
      {1.00, Get["data/HB-100.m"] // Line}},
    "usage" -> "LHCBoundTable[\"2108.07586-Fig12-HB\"] contains a table of {Br(N2->Z), Observed Exclusion Line}.\nThe line is on (Chargino[GeV], LSP[GeV])-plane."
  |>];

BoundData["2108.07586-Fig17"] = IfDataFileExists[<|
  "table" -> {
    {0.25, Import["HEPData-ins1906174-v1-csv/Obslimiton(H~,a~)B(N1->Za~)=25%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
    {0.50, Import["HEPData-ins1906174-v1-csv/Obslimiton(H~,a~)B(N1->Za~)=50%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
    {0.75, Import["HEPData-ins1906174-v1-csv/Obslimiton(H~,a~)B(N1->Za~)=75%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line},
    {1.00, Import["HEPData-ins1906174-v1-csv/Obslimiton(H~,a~)B(N1->Za~)=100%.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True] // Line}},
  "usage" -> "LHCBoundTable[\"2108.07586-Fig17\"] contains a table of {Br(N1->Z), Observed Exclusion Line}.\nThe line is on (Higgsino[GeV], Axino[GeV])-plane."
|>];

(* use "linear" (order = 1) interpolation on LinLinToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2108.07586-CC/WW", "2108.07586-CN/WZ", "2108.07586-CN/WH", "2108.07586-HH/grav"}}
]

End[];
EndPackage[];
