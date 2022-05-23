(* ::Package:: *)

(* :Time-Stamp: <2022-05-23 11:09:13> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


BeginPackage["SimpleLHCBound`"];
Begin["`Private`"];

BoundData["1911.12606"] = <|
  "info" -> <|
    "names"         ->   {
      "1911.12606-WinoPara", "1911.12606-WinoOppo", "1911.12606-Hino", "1911.12606-WinoVBF",
      "1911.12606-SlepLR", "1911.12606-SlepL", "1911.12606-SlepR",
      "1911.12606-SmuLR", "1911.12606-SmuL", "1911.12606-SmuR",
      "1911.12606-SelLR", "1911.12606-SelL", "1911.12606-SelR"
    },
    "collaboration" -> "ATLAS",
    "arXiv"         -> "1911.12606",
    "summary"       -> "1L+H(bb)+mPT",
    "ECM"           -> "13 TeV",
    "luminosity"    -> "139 /fb"
  |>
|>;

Function[
  BoundData[#key] = IfDataFileExists[<|
    "table" -> Block[{raw = Import[#path, "CSV", "SkipLines"->8, "IgnoreEmptyLines"->True]},
      If[FailureQ[raw],
        raw, (* -> handled by IfDataFileExists *)
        (* The files have expected values, which follow observed values. Take until non-number appears. *)
        raw = TakeWhile[raw, AllTrue[NumberQ]];
        (* {mSUSY[GeV], deltaM[GeV], xs[pb]} should be converted to {mSUSY[GeV], deltaM[GeV], xs[fb]} *)
        {#[[1]], #[[2]], #[[3]]*1000} &/@ raw]],
    "usage" -> #usage
  |>];
  AssociateTo[BoundData[#key], "function" ->
    If[Head[BoundData[#key]["table"]] === List,
      IP["LinLog>Log:Delaunay", BoundData[#key]["table"], InterpolationOrder->1, "VerticalScaling"->100],
      (Message[LHCBound::unprepared]; Abort[]) &
    ]
  ]
] /@ {
  <|"key"   -> "1911.12606-WinoPara",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_41ab.csv",
    "usage" -> "LHCBound[\"1911.12606-WinoPara\"][m_Wino(N2=C1)/GeV, \[Delta]m(N2-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-WinoOppo",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_41cd.csv",
    "usage" -> "LHCBound[\"1911.12606-WinoOppo\"][m_Wino(N2=C1)/GeV, \[Delta]m(N2-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-Hino",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_42ab.csv",
    "usage" -> "LHCBound[\"1911.12606-Hino\"][m_Higgsino(heavier)/GeV, \[Delta]m(N2-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-WinoVBF",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_43ab.csv",
    "usage" -> "LHCBound[\"1911.12606-WinoVBF\"][m_Wino(N2=C1)/GeV, \[Delta]m(N2-N1)/GeV] returns upper bounds on \[Sigma]/fb (the header of the CSV seems a typo)."
  |>,
  <|"key"   -> "1911.12606-SlepLR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_44ab.csv",
    "usage" -> "LHCBound[\"1911.12606-SlepLR\"][m_slepLR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SlepL",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_44cd.csv",
    "usage" -> "LHCBound[\"1911.12606-SlepL\"][m_slepL/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SlepR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_44ef.csv",
    "usage" -> "LHCBound[\"1911.12606-SlepR\"][m_slepR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SmuLR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_45ab.csv",
    "usage" -> "LHCBound[\"1911.12606-SmuLR\"][m_smuLR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SmuL",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_45cd.csv",
    "usage" -> "LHCBound[\"1911.12606-SmuL\"][m_smuL/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SmuR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_45ef.csv",
    "usage" -> "LHCBound[\"1911.12606-SmuR\"][m_smuR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SelLR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_46ab.csv",
    "usage" -> "LHCBound[\"1911.12606-SelLR\"][m_selLR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SelL",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_46cd.csv",
    "usage" -> "LHCBound[\"1911.12606-SelL\"][m_selL/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>,
  <|"key"   -> "1911.12606-SelR",
    "path"  -> "data/HEPData-ins1767649-v4-Figure_46ef.csv",
    "usage" -> "LHCBound[\"1911.12606-SelR\"][m_selR/GeV, \[Delta]m(slep-N1)/GeV] returns upper bounds on \[Sigma]/fb."
  |>
};

Print["Warning for 1911.12606:
The Higgsino data (1911.12606-Hino) should be used with a great care.
The bounds are given in terms of N2C1+C1C1+N1N2 cross section, but Sho expect that only N2C1 contribute to the signal events.
See validation.wl as well."]

End[];
EndPackage[];
