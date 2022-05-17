(* ::Package:: *)

(* :Time-Stamp: <2022-5-17 15:49:30> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["1909.09226"] = <|
  "info" -> <|
    "names"         -> {"1909.09226-CN/WH"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "1909.09226",
    "summary"       -> "1L+H(bb)+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

BoundData["1909.09226-CN/WH"] = IfDataFileExists[<|
  "table" -> With[{raw = Import["data/HEPData-ins1755298-v4-Upper_limits_1Lbb.csv", "CSV", "SkipLines"->10, "IgnoreEmptyLines"->True]},
    (* {mN2[GeV], mLSP[GeV], xs[pb]} should be converted to {mN2[GeV], mLSP[GeV], xs[fb]} *)
    {#[[1]], #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"1909.09226-CN/WH\"][m_(N2=C1)/GeV, m_LSP/GeV] returns upper bounds on \[Sigma]/fb."
|>]

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[
  AssociateTo[BoundData[key], "function" ->
    If[Head[BoundData[key]["table"]] === List,
      IP["LinLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ], {key, {"1909.09226-CN/WH"}}
]

End[];
EndPackage[];
