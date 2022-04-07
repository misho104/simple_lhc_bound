(* ::Package:: *)

(* Time-Stamp: <2022-4-7 16:49:48> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
SimpleLHCBound`Private`$Debug=True;
LHCBoundInfo["1908.08215"]
LHCBoundUsage["1908.08215-ll2LR"]
LHCBound["1908.08215-ll2LR"][300, 50]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000 fb;
theory["CC"]   = Get["13TeV.x1x1.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
(* left- and right-handed selectron pair-production *)
theory["seL"] = Get["13TeV.slepslep.LL.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["seR"] = Get["13TeV.slepslep.RR.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["seLR"][m_] := theory["seL"][m]+theory["seR"][m]


SetOptions[ContourPlot, Contours->{1}, ContourShading->None];
plot["CCWW"] = ContourPlot[LHCBound["1908.08215-CC/WW"]  [mc, m1] / theory["CC"][mc], {mc, 100,  500}, {m1, 0, 220}]
plot["CCsl"] = ContourPlot[LHCBound["1908.08215-CC/slep"][mc, m1] / theory["CC"][mc], {mc, 100, 1200}, {m1, 0, 700}]
plot["slep"] = Show[{
  (* Thick: se+smu, Dashed: one of them; Black: L+R, Red: L, Cyan: R *)
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]*2), {ml,100,800}, {m1,0,500}, ContourStyle->Directive[{Thick,Black}]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]*2),  {ml,100,800}, {m1,0,500}, ContourStyle->Directive[{Thick,Red}]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]*2),  {ml,100,800}, {m1,0,500}, ContourStyle->Directive[{Thick,Cyan}]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]),   {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Black,Dashed]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]),    {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Red,Dashed]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]),    {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Cyan,Dashed]]
}]


atlas["CCWW"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_07a.png"];
atlas["CCsl"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_07b.png"];
Show[{ImageResize[Image[plot["CCWW"]],400],ImagePad[ImageResize[SetAlphaChannel[atlas["CCWW"], 0.2],{381, 391}],{{23,0},{12,0}}]}]
Show[{ImageResize[Image[plot["CCsl"]],400],ImagePad[ImageResize[SetAlphaChannel[atlas["CCsl"], 0.2],{456, 418}],{{6,0},{8,0}}]}]


(* Thick: se+smu, Dashed: one of them; Black: L+R, Red: L, Cyan: R *)
Print[Show[{#,ImageResize[Image[plot["slep"]],400]}]]&/@{
  ImagePad[ImageResize[SetAlphaChannel[Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_07c.png"], 0.4],{352, 431}],{{27,0},{6,0}}],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/figaux_01.png"], 0.4],{345, 469}],{{22,0},{0,0}}],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/figaux_02.png"], 0.4],{345, 469}],{{22,0},{0,0}}],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_08a.png"], 0.4],{298, 390}],{{30,0},{13,0}}],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_08b.png"], 0.4],{298, 390}],{{30,0},{13,0}}]
};



