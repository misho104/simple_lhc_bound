(* ::Package:: *)

(* Time-Stamp: <2022-05-22 14:38:13> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["2004.05153"] = <|
  "info" -> <|
    "names"         -> {"2004.05153-Wino", "2004.05153-Higgsino"},
    "collaboration" -> "CMS",
    "arXiv"         -> "2004.05153",
    "summary"       -> "Disappearing track",
    "ECM"           -> "13 TeV",
    "luminosity"    -> {"140 /fb", "101 /fb"}
  |>
|>;

BoundData["2004.05153-Wino"] = <|
  "table" -> With[{raw = Import[
      "HEPData-ins1790827-v2-csv/Crosssectionlimitsvs.lifetimeandmass,WinoLSP.csv",
      "CSV"
    ][[6;;500]]},
    (* {t[ns], m[GeV], xs[pb]} should be converted to {t[s], m[GeV], xs[fb]} *)
    {#[[1]]*10^-9, #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2004.05153-Wino\"][lifetime/s, mass/GeV] returns upper bounds on \[Sigma]/fb."
|>

BoundData["2004.05153-Higgsino"] = <|
  "table" -> With[{raw = Import[
      "HEPData-ins1790827-v2-csv/Crosssectionlimitsvs.lifetimeandmass,HiggsinoLSP.csv",
      "CSV"
    ][[6;;410]]},
    (* {t[ns], m[GeV], xs[pb]} should be converted to {t[s], m[GeV], xs[fb]} *)
    {#[[1]]*10^-9, #[[2]], #[[3]]*1000} &/@ raw],
  "usage" -> "LHCBound[\"2004.05153-Higgsino\"][lifetime/s, mass/GeV] returns upper bounds on \[Sigma]/fb."
|>

(* use "linear" (order = 1) interpolation on LogLogToLog Delaunay mesh *)
Do[AssociateTo[BoundData[key], "function" -> IP["LogLog>Log:Delaunay", BoundData[key]["table"], InterpolationOrder->1]],
  {key, {"2004.05153-Wino", "2004.05153-Higgsino"}}]

Print["Warning for 2004.05153:
An inconsistency in found in the Higgsino data, which thus should be used carefully.
See validation.wl."]

End[];
EndPackage[];
