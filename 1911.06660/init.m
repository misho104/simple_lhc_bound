(* ::Package:: *)

(* :Time-Stamp: <2022-05-17 17:24:20> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["1911.06660"] = <|
  "info" -> <|
    "names"         -> {"1911.06660-stau", "1911.06660-stauL"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "1911.06660",
    "summary"       -> "2hadtau+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["1911.06660-stau"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/HEPData-ins1765529-v2-X-section_U.L_1.csv", "CSV", "SkipLines"->11, "IgnoreEmptyLines"->True]},
    (* {mstau[GeV], mLSP[GeV], xs[pb]} should be converted to {mstau[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"1911.06660-stau\"][m_(stauL=stauR)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

BoundData["1911.06660-stauL"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/HEPData-ins1765529-v2-X-section_U.L_2.csv", "CSV", "SkipLines"->11, "IgnoreEmptyLines"->True]},
    (* {mstau[GeV], mLSP[GeV], xs[pb]} should be converted to {mstau[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"1911.06660-stauL\"][m_stau/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"1911.06660-stau", "1911.06660-stauL"}}
]

End[];
EndPackage[];
