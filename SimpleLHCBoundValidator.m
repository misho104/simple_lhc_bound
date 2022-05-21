(* ::Package:: *)

(* Time-Stamp: <2022-05-22 20:38:07> *)

(* :Title: Validation Helper for Simple LHC Bound *)
(* :Context: SimpleLHCBoundValidator` *)

(* :Author: Sho Iwamoto / Misho *)
(* :Copyright: 2022 Sho Iwamoto / Misho *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)

BeginPackage["SimpleLHCBoundValidator`"];

(* Usage messages *)
FMT = StringReplace[{
  RegularExpression["<(.+?)>"] -> "\!\(\*StyleBox[\"$1\", \"SO\"]\)",     (* arg *)
  RegularExpression["#(.+?)#"] -> "\!\(\*StyleBox[\"$1\", \"TI\"]\)",     (* options *)
  RegularExpression["\\*(.+?)\\*"] -> "\!\(\*StyleBox[\"$1\", \"SB\"]\)", (* emphasize *)
  RegularExpression["'(\\w+)'"] -> "\!\(\*StyleBox[\"\[OpenCurlyDoubleQuote]$1\[CloseCurlyDoubleQuote]\", \"MR\"]\)",  (* quoted fixed string *)
  RegularExpression["`(\\w+)`"] -> "\!\(\*StyleBox[\"$1\", \"MR\"]\)"     (* fixed string *)
}]@*StringTrim;

PlotOverlay::usage = FMT["
*PlotOverlay*[#plot#, #image#, #parameters#] displays the overlay of #plot# on #image#.
One can find the overlay paremters #parameters# by `FindOverlay` function.
"]

GetFrame::usage = FMT["
*GetFrame*[#image#] tries to find the plot frame in #image#.
Debugging information is stored in `DebugInfo`.
"];

ImageClear::usage = FMT["
*ImageClear*[#image#, #left#, #right#, #bottom#, #top#] clears specified pixels of #image#.
"];

FindOverlay::usage = FMT["
*FindOverlay*[#plot#, #image#, #frame#, #imageX#, #imageY#] tries to find the parameter set for `PlotOverlay` function.
#plot# is the plot to be validated, #image# is to be the actual LHC figure.
#frame# is the result of `GetFrame` function.
The edges of horizontal and vertical axes are expected to be stored in #imageX# and #imageY#.
Debugging information is stored in `DebugInfo`.
"];

DebugInfo::usage = FMT["*DebugInfo* stores the last-generated graphic for debugging."];
DefaultSize::usage = FMT["*DefaultSize* is the default size of the graphic."];

Remove[FMT];

(* messages *)
FindOverlay::invalid = "GraphRescale is called with invalid frame information.";
DebugInfo = None;
DefaultSize = 400;

Begin["`Private`"];
Unprotect[GetFrame, FindOverlay, PlotOverlay];
$OutputPDF = False;

GetFrame[image_] := Block[{edge, lines, horizontal, vertical, x, y, w, h},
  edge = EdgeDetect[Binarize[RemoveAlphaChannel[image]]];
  lines = ImageLines[edge, 0.2, MaxFeatures->8];
  horizontal = Select[lines, -0.05 < Mod[(ArcTan@@(#[[1,1]]-#[[1,2]]))/Pi, 1, -0.5] < 0.05&][[;;2]];
  vertical   = Select[lines,  0.45 < Mod[(ArcTan@@(#[[1,1]]-#[[1,2]]))/Pi, 1      ] < 0.55&][[;;2]];
  w = Max[#[[1, All, 1]] &/@ horizontal];
  h = Max[#[[1, All, 2]] &/@ vertical];
  x = Mean[#[[1, All, 1]]] &/@ vertical;
  y = Mean[#[[1, All, 2]]] &/@ horizontal;
  DebugInfo = {HighlightImage[image, Join[
    Line[{{0, #}, {w, #}}] &/@ y,
    Line[{{#, 0}, {#, h}}] &/@ x
  ]], lines};
  <|"Size"->{w, h}, "X"->Sort[x], "Y"->Sort[y]|>
];


ImageClear[image_, left_:0, right_:0, bottom_:0, top_:0] := Block[{dim = ImageDimensions[image]},
  image
  // ImageTrim[#, {{0 + left, 0 + bottom}, {dim[[1]] - right, dim[[2]] - top}}] &
  // ImagePad[#, {{left, right}, {bottom, top}}, White] &
]

d[{x_, y_}] := Abs[y - x];

FindOverlay[plot_, image_, framein_:None, imageXin_:None, imageYin_:None] := Block[{
  plotX, plotY, frame, imageX, imageY, rx, ry, newX, newY, newSize, aspect, result
},
  {plotX, plotY} = PlotRange /. plot[[2]];
  frame  = If[framein === None, GetFrame[image], framein];
  imageX = If[imageXin === None, plotX, imageXin];
  imageY = If[imageYin === None, plotY, imageYin];
  If[{Length[frame["X"]], Length[frame["Y"]]} != {2, 2}, Message[FindOverlay::invalid]; Abort[]];

  rx = DefaultSize / frame["Size"][[1]];
  ry = rx * d[frame["X"]] / d[frame["Y"]] * d[plotX] / d[plotY] * d[imageY] / d[imageX];
  newX = rx * frame["X"] // Round[#, 0.01]&;
  newY = ry * frame["Y"] // Round[#, 0.01]&;
  newSize = {rx, ry} * frame["Size"] // Round[#, 0.1] &;
  DebugInfo = HighlightImage[ImageResize[image, newSize], Join[
    Line[{{0, #}, {newSize[[1]], #}}] &/@ newY,
    Line[{{#, 0}, {#, newSize[[2]]}}] &/@ newX
  ]];
  aspect = d[imageX] * newSize[[1]] / d[newX] // Round[#, 0.1]&;
  result = {newSize, {imageX[[1]], imageY[[1]]}, {newX[[1]], newY[[1]]}, aspect};
  Print[InputForm[TextString[result]]];
  result
]

Attributes[PlotOverlay] = {HoldFirst};
Options[PlotOverlay] = {"alpha" -> 0.5};
PlotOverlay[plot_, image_, parameters_, OptionsPattern[]] := Block[{title, output, filename},
  title = Cases[Hold[plot], _Symbol[n_String] :> n, 1];
  output = Show[plot, Prolog->Inset[
    ImageResize[SetAlphaChannel[image, OptionValue["alpha"]], parameters[[1]]],
    parameters[[2]],
    parameters[[3]],
    parameters[[4]]
  ], PlotRangeClipping->False];
  If[$OutputPDF && Length[title] > 0,
    filename = "validation." <> StringReplace[title[[1]], RegularExpression["\\W"]->""] <> ".pdf";
    If[MemberQ[$ContextPath, "PlotTools`"], output = PlotTools`EvaluatePlot[output]];
    Export[filename, Magnify[output, 1]];
  ];
  output];


End[];
Protect[GetFrame, FindOverlay, PlotOverlay];
EndPackage[];
