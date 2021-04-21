(* ::Package:: *)

(* Time-Stamp: <2021-04-21 19:56:39> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["1908.08215"] = <|
  "info" -> <|
    "names"         -> {"1908.08215-CC/WW", "1908.08215-CC/slep", "1908.08215-ll2LR"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "1908.08215",
    "summary"       -> "2L+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["1908.08215-CC/WW"] = <|
  "table" -> Import["HEPData-ins1750597-v2-csv/xsecupperlimits1.csv", "CSV", "SkipLines"->10, "IgnoreEmptyLines"->True],
  "usage" -> "LHCBound[\"1908.08215-CC/WW\"][m_chargino/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>;

BoundData["1908.08215-CC/slep"] = <|
  "table" -> Import["HEPData-ins1750597-v2-csv/xsecupperlimits2.csv", "CSV", "SkipLines"->10, "IgnoreEmptyLines"->True],
  "usage" -> "LHCBound[\"1908.08215-CC/slep\"][m_chargino/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>;

BoundData["1908.08215-ll2LR"] = <|
  "table" -> Import["HEPData-ins1750597-v2-csv/xsecupperlimits3.csv", "CSV", "SkipLines"->10, "IgnoreEmptyLines"->True],
  "usage" -> "LHCBound[\"1908.08215-ll2LR\"][m_slepton/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb.\nIt is assumed that left-handed and right-handed selectron and smuon are degenerate and present."
|>;

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"1908.08215-CC/WW", "1908.08215-CC/slep", "1908.08215-ll2LR"}}
]

End[];
EndPackage[];
