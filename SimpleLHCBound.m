(* ::Package:: *)

(* Time-Stamp: <2022-05-22 14:38:02> *)

(* :Title: Simple LHC Bound *)
(* :Context: SimpleLHCBound` *)

(* :Author: Sho Iwamoto / Misho *)
(* :Copyright: 2021 Sho Iwamoto / Misho *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)

(* :Package Version: 0.0.1 *)
(* :Mathematica Version: 12.0 *)
(* :History:
   0.0.1 (2021 Apr.) initial version
*)

BeginPackage["SimpleLHCBound`"];

Unprotect[LHCBoundTable, LHCBound, LHCBoundUsage, LHCBoundInfo];
Quiet[Remove["SimpleLHCBound`*", "SimpleLHCBound`Private`*"], Remove::rmnsm];

(* Configuration *)
$LHCBoundDirectory = DirectoryName[$InputFileName];

(* Usage messages *)
FMT = StringReplace[{
  RegularExpression["<(.+?)>"] -> "\!\(\*StyleBox[\"$1\", \"SO\"]\)",     (* arg *)
  RegularExpression["#(.+?)#"] -> "\!\(\*StyleBox[\"$1\", \"TI\"]\)",     (* options *)
  RegularExpression["\\*(.+?)\\*"] -> "\!\(\*StyleBox[\"$1\", \"SB\"]\)", (* emphasize *)
  RegularExpression["'(\\w+)'"] -> "\!\(\*StyleBox[\"\[OpenCurlyDoubleQuote]$1\[CloseCurlyDoubleQuote]\", \"MR\"]\)",  (* quoted fixed string *)
  RegularExpression["`(\\w+)`"] -> "\!\(\*StyleBox[\"$1\", \"MR\"]\)"     (* fixed string *)
}]@*StringTrim;

LHCBound::usage = FMT["
*LHCBound*[#name#] contains a interpolation function describing the constraint #name#.
Function's argment depends on each constraint; see Usually in our standard metric (GeV, fb, etc.).
See *LHCBoundUsage*[#name#] for usage and descriptions.
"];
LHCBoundTable::usage = FMT["
*LHCBoundTable*[#name#] contains raw table data for the constraint #name#.
Usually in our standard metric (GeV, fb, etc.).
"];
LHCBoundUsage::usage = FMT["*LHCBoundUsage*[#name#] displays the usage of *LHCBound*[#name#]."];
LHCBoundInfo::usage = FMT["*LHCBoundInfo*[#name#] contains information on the constraint #name#."];

ResetBound::usage = FMT["*ResetBound*[] clears loaded bound data, mainly for developers."];

$LHCBoundDirectory::usage = FMT["*$LHCBoundDirectory* contains the path to this package, where the constraint data are stored."];

Remove[FMT];

(* messages *)
LHCBound::invalid = "The name \"`1`\" is invalid as a constraint name.";
LHCBound::notfound = "LHC Constraint \"`1`\" is not found.";
LHCBound::undefined = "LHC Constraint \"`1`\" found but `2` not provided.";
LHCBound::unprepared = "This constraint is not available because data files are not prepared. See README.";

Begin["`Private`"];
(*protected = Unprotect[ Sin, Cos ]*)

$Debug = False;

LHCBound[name_] := GetBoundData[name, "function"]
LHCBoundTable[name_] := GetBoundData[name, "table"]
LHCBoundUsage[name_] := GetBoundData[name, "usage"]
LHCBoundInfo[name_] := GetBoundData[name, "info"]

(* the actual data storage, which should contains an association for each name *)
BoundData[name_] := Undefined;

ResetBound[] := (ClearAll[BoundData]; BoundData[name_] := Undefined);

(* getter *)
GetBoundData[name_, content_] := Module[{found},
  (* if already loaded *)
  found = BoundData[name];
  If[Head[found] =!= Association,
    LoadData[name];
    found = BoundData[name];
  ];
  If[Head[found] === Association,
    If[KeyExistsQ[found, content], Return[found[content]]];
    Message[LHCBound::undefined, name, content];
    Return[Undefined];
  ];
  Message[LHCBound::notfound, name]]

(* name must be in this form to avoid vulnerability;
   should be extended if more format comes *)
BoundNamesPattern = {
  RegularExpression["^(\\d{4}\\.\\d{5})(-(.*))?$"]->{"$1", "$3"}
};
ParseBoundName[name_] := Module[{result}, Do[
    result = StringCases[name, pat];
    If[Length[result] > 0, Break[]];
  , {pat,  BoundNamesPattern}];
  If[Length[result] > 0, Return[First[result]]];
  Message[LHCBound::invalid, name];
  Abort[]
]

(* file loading system *)
LoadData[name_] := Module[{paper, key, path},
  {paper, key} = ParseBoundName[name];
  path = FileNameJoin[{$LHCBoundDirectory, paper, "init.m"}];
  If[FileExistsQ[path], Get[path]]]

Attributes[IfDataFileExists] = {HoldAll};
IfDataFileExists[code_] := With[{imported = Evaluate[code]},
  If[FailureQ[imported["table"]],
    Return[<|"table"->None, "usage"->"This constraint is not available because data files are not prepared. See README2."|>]];
  imported
]

(* helper functions *)
SafeLog10[x_?NumericQ] := If[x>0, Log10[x], N[MachinePrecision]]; (* "0" in data actually corresponds no bound. *)

(* Delaunay Interpolation Helper *)
Needs["NDSolve`FEM`"];
DelaunayToElementMesh[dmesh_] := NDSolve`FEM`ToElementMesh[
  "Coordinates" -> MeshCoordinates[dmesh],
  "MeshElements" -> {TriangleElement @ Pick[
    First @ Thread[MeshCells[dmesh, 2], Polygon],
    Unitize[Chop @ Flatten@ PropertyValue[{dmesh, 2}, MeshCellMeasure]],
    1]
  }
];

GetMesh[table_, squeeze_, scale_] := Block[{
    delaunay
  },
  delaunay = Quiet[
    TransformedRegion[
      DelaunayMesh[{#[[1]], scale * #[[2]] - #[[1]] * squeeze}&/@table],
      {#[[1]], (#[[2]] + #[[1]] * squeeze) / scale}&
    ], MeshRegion::dgcellr];
  DelaunayToElementMesh[delaunay]
]

(* Interpolation *)

Options[IP] = {
  "SkewDelta"->0.0001,
  "VerticalScaling"->1,
  InterpolationOrder->1,
  Method->Automatic,
  PeriodicInterpolation->False,
  "ExtrapolationHandler" -> {Function[Indeterminate], "WarningMessage" -> False}
};

IP["Log>Log", table_, OptionsPattern[]] := With[{
    ip = Interpolation[
      {Log10[#[[1]]], SafeLog10[#[[2]]]} &/@ table,
      InterpolationOrder->OptionValue[InterpolationOrder],
      Method->OptionValue[Method],
      PeriodicInterpolation->OptionValue[PeriodicInterpolation],
      "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
     ]
  },
  10^(ip[Log10[#]])&]

IP["LogLog>Log", table_, OptionsPattern[]] := With[{
    ip = Interpolation[
      {Log10[#[[1]]], Log10[#[[2]]], SafeLog10[#[[3]]]} &/@ table,
      InterpolationOrder->OptionValue[InterpolationOrder],
      Method->OptionValue[Method],
      PeriodicInterpolation->OptionValue[PeriodicInterpolation],
      "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
    ]
  },
  10^(ip[Log10[#1], Log10[#2]])&]

IP["LinLin>Log:Delaunay", table_, OptionsPattern[]] := Module[{
   key = {#[[1]], #[[2]]} &/@ table,
   value = SafeLog10[#[[3]]] &/@ table,
   mesh, ip},
  mesh = GetMesh[key, OptionValue["SkewDelta"], OptionValue["VerticalScaling"]];
  If[$Debug, Show[{Graphics[mesh["Wireframe"][[1]], Axes->True, AspectRatio->1/GoldenRatio], ListPlot[key]}]//Print];
  ip = NDSolve`FEM`ElementMeshInterpolation[{mesh}, value,
    InterpolationOrder->OptionValue[InterpolationOrder],
    Method->OptionValue[Method],
    PeriodicInterpolation->OptionValue[PeriodicInterpolation],
    "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
  ];
  10^(ip[#1, #2])&]

IP["LogLin>Log:Delaunay", table_, OptionsPattern[]] := Module[{
   key = {Log10[#[[1]]], #[[2]]} &/@ table,
   value = SafeLog10[#[[3]]] &/@ table,
   mesh, ip},
  mesh = GetMesh[key, OptionValue["SkewDelta"], OptionValue["VerticalScaling"]];
  If[$Debug, Show[{Graphics[mesh["Wireframe"][[1]], Axes->True, AspectRatio->1/GoldenRatio], ListPlot[key]}]//Print];
  ip = NDSolve`FEM`ElementMeshInterpolation[{mesh}, value,
    InterpolationOrder->OptionValue[InterpolationOrder],
    Method->OptionValue[Method],
    PeriodicInterpolation->OptionValue[PeriodicInterpolation],
    "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
  ];
  10^(ip[Log10[#1], #2])&]

IP["LinLog>Log:Delaunay", table_, OptionsPattern[]] := Module[{
   key = {#[[1]], Log10[#[[2]]]} &/@ table,
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
  10^(ip[#1, Log10[#2]])&]

IP["LogLog>Log:Delaunay", table_, OptionsPattern[]] := Module[{
   key = {Log10[#[[1]]], Log10[#[[2]]]} &/@ table,
   value = SafeLog10[#[[3]]] &/@ table,
   mesh, ip},
  mesh = GetMesh[key, OptionValue["SkewDelta"], OptionValue["VerticalScaling"]];
  If[$Debug, Show[{Graphics[mesh["Wireframe"][[1]], Axes->True, AspectRatio->1/GoldenRatio], ListPlot[key]}]//Print];
  ip = NDSolve`FEM`ElementMeshInterpolation[{mesh}, value,
    InterpolationOrder->OptionValue[InterpolationOrder],
    Method->OptionValue[Method],
    PeriodicInterpolation->OptionValue[PeriodicInterpolation],
    "ExtrapolationHandler"->OptionValue["ExtrapolationHandler"]
  ];
  10^(ip[Log10[#1], Log10[#2]])&]


(*Protect[Evaluate[protected]]*)
End[];
Protect[LHCBoundTable, LHCBound, LHCBoundUsage, LHCBoundInfo];
EndPackage[];
