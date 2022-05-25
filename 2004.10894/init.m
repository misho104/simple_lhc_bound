(* ::Package:: *)

(* :Time-Stamp: <2022-05-26 15:58:11> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2004.10894"] = <|
  "info" -> <|
    "names"         -> {"2004.10894-CN/WH", "2004.10894-HiggsinoGrav"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "2004.10894",
    "summary"       -> "H(gammagamma)+(1l or 2j or mPT)",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["2004.10894-CN/WH"] = IfDataFileExists[<|
  "table" -> Block[{
      raw = Import["data/HEPData-ins1792399-v1-Table_07.csv", "CSV", "SkipLines"->0, "IgnoreEmptyLines"->True],
      gathered, m2m1m2ul
    },
    (* the table is malformed; need to arrange to obtain {mN2[GeV], mLSP[GeV], xs[fb]}
       note that the cross section is pb (see Aux. Table 7 on the website) despite it is notated as "fb". *)
    gathered = SplitBy[raw, FreeQ[_String]];
    If[FreeQ[gathered[[5]], "Observed fb"], Print["The data file HEPData-ins1792399-v1-Table_07.csv might be corrupted."]];
    m2m1m2ul = Flatten /@ Thread[List[gathered[[2]], gathered[[6]]]];
    If[AnyTrue[#[[1]]=!=#[[3]]&][m2m1m2ul], Print["The data file HEPData-ins1792399-v1-Table_07.csv might be corrupted."]];
    {#[[1]], #[[2]], #[[4]]*1000} &/@ m2m1m2ul],
  "usage" -> "LHCBound[\"2004.10894-CN/WH\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["2004.10894-HiggsinoGrav"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/HEPData-ins1792399-v1-Figure_11.csv", "CSV", "SkipLines"->9, "IgnoreEmptyLines"->True]},
    (* {mHino[GeV], xs[pb]} should be converted to {mHino[GeV], xs[fb]} *)
    {#[[1]], #[[2]]*1000} &/@ TakeWhile[raw, AllTrue[NumberQ]]],
  "usage" -> "LHCBound[\"2004.10894-HiggsinoGrav\"][m_(N2=C1=N1)/GeV] returns upper bounds on \[Sigma]/fb."
|>]

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2004.10894-CN/WH"}}
];

Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["Log>Log", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2004.10894-HiggsinoGrav"}}
]

End[];
EndPackage[];
