(* ::Package:: *)

(* :Time-Stamp: <2022-05-28 20:06:40> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2106.01676"] = <|
  "info" -> <|
    "names"         -> {"2106.01676-WinoPara/WZ", "2106.01676-WinoOppo/WZ", "2106.01676-Higgsino/WZ", "2106.01676-WinoPara/WH"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "2106.01676",
    "summary"       -> "3l + mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

(* Using values, not on HEPdata, but read from auxiliary tables on the website
   https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/ *)

BoundData["2106.01676-WinoPara/WZ"] = IfDataFileExists[<|
  "table" -> Block[{raw = Import["data/merged_WinoParaWZ.csv", "CSV", "SkipLines"->0, "IgnoreEmptyLines"->True]},
    (* {m(N2=C1)[GeV], mN2-mN1[GeV], obs-xs[pb], exp-xs[pb]} should be converted to {mN2[GeV], mN1[GeV], obs-xs[fb]} *)
    {#[[1]], #[[1]]-#[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2106.01676-WinoPara/WZ\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["2106.01676-WinoOppo/WZ"] = IfDataFileExists[<|
  "table" -> Block[{raw = Import["data/merged_WinoOppoWZ.csv", "CSV", "SkipLines"->0, "IgnoreEmptyLines"->True]},
    (* {m(N2=C1)[GeV], mN2-mN1[GeV], obs-xs[pb], exp-xs[pb]} should be converted to {mN2[GeV], mN1[GeV], obs-xs[fb]} *)
    {#[[1]], #[[1]]-#[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2106.01676-WinoOppo/WZ\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["2106.01676-Higgsino/WZ"] = IfDataFileExists[<|
  "table" -> Block[{raw = Import["data/merged_HiggsinoWZ.csv", "CSV", "SkipLines"->0, "IgnoreEmptyLines"->True]},
    (* {mN2[GeV], mN2-mN1[GeV], obs-xs[pb], exp-xs[pb]} should be converted to {mN2[GeV], mN1[GeV], obs-xs[fb]} *)
    {#[[1]], #[[1]]-#[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2106.01676-Higgsino/WZ\"][m_N2/GeV, m_N1/GeV] returns upper bounds on \[Sigma]/fb with m_C1 being (mN1 + mN2)/2."
|>]

BoundData["2106.01676-WinoPara/WH"] = IfDataFileExists[<|
  "table" -> Block[{raw = Import["data/merged_WinoParaWH.csv", "CSV", "SkipLines"->0, "IgnoreEmptyLines"->True]},
    (* {m(N2=C1)[GeV], mN2-mN1[GeV], obs-xs[pb], exp-xs[pb]} should be converted to {mN2[GeV], mN1[GeV], obs-xs[fb]} *)
    {#[[1]], #[[1]]-#[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2106.01676-WinoPara/WH\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]


(* use "linear" (order = 1) interpolation but on [mN2, log(mN2-mN21)] Delaunay mesh *)
IP["2106.01676", table_, OptionsPattern[]] := Module[{
   key = {#[[1]], Log10[#[[1]] - #[[2]] + 1]} &/@ table,
   value = SafeLog10[#[[3]]] &/@ table,
   mesh, ip, delta = 0.000001},
  mesh = GetMesh[key, OptionValue["SkewDelta"], OptionValue["VerticalScaling"]];
  If[$Debug, Show[{Graphics[mesh["Wireframe"][[1]], Axes->True, AspectRatio->1/GoldenRatio], ListPlot[key]}]//Print];
  ip = NDSolve`FEM`ElementMeshInterpolation[{mesh}, value,
    InterpolationOrder->OptionValue[InterpolationOrder],
    Method->OptionValue[Method],
    PeriodicInterpolation->OptionValue[PeriodicInterpolation],
    "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
  ];
  10^(ip[#1, Log10[#1 - #2 + 1]])&]

Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["2106.01676", BoundData[key]["table"], InterpolationOrder->1, "VerticalScaling"->100],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2106.01676-WinoPara/WZ", "2106.01676-WinoOppo/WZ", "2106.01676-Higgsino/WZ"}}
];
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2106.01676-WinoPara/WH"}}
];

Print["Warning for 2106.01676:
Interpolation provided by this package may be not suitable for some region.
It is advised to use your customized interpolation function for such cases.
An inconsistency is also found for Wh-mediated case, for which see validation.wl."]


End[];
EndPackage[];
