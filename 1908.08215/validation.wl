(* ::Package:: *)

(* Time-Stamp: <2021-4-21 20:04:51> *)

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
ContourPlot[LHCBound["1908.08215-CC/WW"]  [mc, m1] / theory["CC"][mc], {mc, 100,  500}, {m1, 0, 220}]
ContourPlot[LHCBound["1908.08215-CC/slep"][mc, m1] / theory["CC"][mc], {mc, 100, 1200}, {m1, 0, 700}]
Show[{
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]*2),  {ml,100,800}, {m1,0,500}, ContourStyle->Blue],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]*2),  {ml,100,800}, {m1,0,500}, ContourStyle->Green],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]*2), {ml,100,800}, {m1,0,500}, ContourStyle->Black],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]),    {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Blue,Dashed]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]),    {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Green,Dashed]],
  ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]),   {ml,100,800}, {m1,0,500}, ContourStyle->Directive[Black,Dashed]]
}]



