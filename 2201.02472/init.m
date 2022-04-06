(* ::Package:: *)

(* Time-Stamp: <2022-04-06 18:08:52> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2201.02472"] = <|
  "info" -> <|
    "names"         -> {"2201.02472-Wino", "2201.02472-Higgsino"},
    "collaboration" -> "ATLAS",
    "arXiv"         -> "2201.02472",
    "summary"       -> "Disappearing track",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "136 /fb"
  |>
|>;

BoundData["2201.02472-Wino"] = <|
  "table" -> With[{raw = Import[
      "data/WinoAcceptance.csv",
      "CSV"
    ][[5;;154]]},
    (* {t[ns], m[GeV], AcceptanceTimesEfficiency} should be converted to {t[s], m[GeV], xs[fb]} *)
    (* 95%-CL upper bounds on cross section (observed) is 0.037 fb (Table 8) *)
    {#[[1]]*10^-9, #[[2]], 0.037 / #[[3]]} &/@ raw],
  "usage" -> "LHCBound[\"2201.02472-Wino\"][lifetime/s, mass/GeV] returns upper bounds on \[Sigma]/fb."
|>

BoundData["2201.02472-Higgsino"] = <|
  "table" -> With[{raw = Import[
      "data/hinoAcceptance.csv",
      "CSV"
    ][[5;;154]]},
    (* {t[ns], m[GeV], AcceptanceTimesEfficiency} should be converted to {t[s], m[GeV], xs[fb]} *)
    (* 95%-CL upper bounds on cross section (observed) is 0.037 fb (Table 8) *)
    {#[[1]]*10^-9, #[[2]], 0.037 / #[[3]]} &/@ raw],
  "usage" -> "LHCBound[\"2201.02472-Higgsino\"][lifetime/s, mass/GeV] returns upper bounds on \[Sigma]/fb."
|>

(* use "linear" (order = 1) interpolation on LogLinToLog Delaunay mesh *)
Do[AssociateTo[BoundData[key], "function" -> IP["LogLin>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1]],
  {key, {"2201.02472-Wino", "2201.02472-Higgsino"}}]

Print["Warning for 2201.02472:
The bounds calculated by this program is too strict compared to the original paper.
The difference amounts to 30–40% in the cross section, or 10–50 GeV in the chargino mass.
See validation.wl."]

End[];
EndPackage[];
