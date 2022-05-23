(* ::Package:: *)

(* :Time-Stamp: <2022-05-19 13:11:47> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["1912.08479"] = <|
  "info" -> <|
    "names"         -> {"1912.08479-CN/WZ"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "1912.08479",
    "summary"       -> "3L+mPT(+ISR)",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["1912.08479-CN/WZ"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/HEPData-ins1771533-v2-Observed_Upper_Limits.csv", "CSV", "SkipLines"->11, "IgnoreEmptyLines"->True]},
    (* {mN2[GeV], mLSP[GeV], xs[pb]} should be converted to {mN2[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"1912.08479-CN/WZ\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"1912.08479-CN/WZ"}}
]

End[];
EndPackage[];
