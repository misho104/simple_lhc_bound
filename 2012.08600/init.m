(* ::Package:: *)

(* Time-Stamp: <2021-04-21 20:36:56> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2012.08600"] = <|
  "info" -> <|
    "names"         -> {"2012.08600-gg", "2012.08600-WZ", "2012.08600-bb1", "2012.08600-qq8", "2012.08600-ll1LR"},
    "collaboration" -> "CMS",
    "arXiv"         -> "2012.08600",
    "summary"       -> "2L+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "137 /fb"
  |>
|>;

BoundData["2012.08600-gg"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/Figure_010.csv", "CSV"]},
    (* {mgl[GeV], mN1[GeV], xs[pb]} should be converted to {mgl[GeV], mN1[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2012.08600-gg\"][m_gluino/GeV, m_neutralino1/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["2012.08600-WZ"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/Figure_011.csv", "CSV"]},
    (* {mN2[GeV], mLSP[GeV], xs[pb]} should be converted to {mN2[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2012.08600-WZ\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["2012.08600-bb1"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/Figure_013-a.csv", "CSV"]},
    (* {mSB[GeV], mN2[GeV], xs[pb]} should be converted to {mSB[GeV], mN2[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2012.08600-bb1\"][m_sbottom/GeV, m_neutralino2/GeV] returns upper bounds on \[Sigma]/fb.\nIt is assumed that single sbottom (left OR right) is contributing to the cross section."
|>]

BoundData["2012.08600-qq8"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/Figure_013-b.csv", "CSV"]},
    (* {mSQ[GeV], mN2[GeV], xs[pb]} should be converted to {mSQ[GeV], mN2[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2012.08600-qq8\"][m_squark/GeV, m_neutralino2/GeV] returns upper bounds on \[Sigma]/fb.\nIt is assumed that eight light-flavor squarks are degenerate and contributing to the cross section."
|>]

BoundData["2012.08600-ll1LR"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/Figure_014.csv", "CSV"]},
    (* {mSL[GeV], mLSP[GeV], xs[pb]} should be converted to {mSL[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2012.08600-ll1LR\"][m_slepton/GeV, m_neutralino2/GeV] returns upper bounds on \[Sigma]/fb.\nIt is assumed that left-handed and right-handed selectron (or smuon) are degenerate and contributing to the cross section.\nSmuon (or selectron) and stau are set decoupled."
|>]

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"2012.08600-gg", "2012.08600-WZ", "2012.08600-bb1", "2012.08600-qq8", "2012.08600-ll1LR"}}
]

End[];
EndPackage[];
