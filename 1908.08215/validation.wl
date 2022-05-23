(* ::Package:: *)

(* Time-Stamp: <2022-05-21 21:04:21> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug = True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
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
plot["CCWW"] = ContourPlot[LHCBound["1908.08215-CC/WW"]  [mc, m1] / theory["CC"][mc], {mc, 100,  500}, {m1, 0, 220}];
plot["CCsl"] = ContourPlot[LHCBound["1908.08215-CC/slep"][mc, m1] / theory["CC"][mc], {mc, 100, 1400}, {m1, 0, 750}] // OverrideTicks[LinTicks[200, 1400], LinTicks[100, 750, 10], {}, {}];

plot["2LR"] = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]*2), {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[{Thick,Black}]];
plot["2L"]  = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]*2),  {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[{Thick,Red}]];
plot["2R"]  = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]*2),  {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[{Thick,Cyan}]];
plot["1LR"] = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seLR"][ml]),   {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[Black,Dashed]];
plot["1L"]  = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seL"][ml]),    {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[Red,Dashed]];
plot["1R"]  = ContourPlot[LHCBound["1908.08215-ll2LR"][ml, m1] / (theory["seR"][ml]),    {ml,100,1000}, {m1,0,500}, ContourStyle->Directive[Cyan,Dashed]];

plot["slepLR"] = Show[plot["2LR"], plot["2L"], plot["2R"], PlotRange->{{100, 720}, {0, 600}}];
plot["slepEM"] = Show[plot["2LR"], plot["1LR"], PlotRange->{{100, 720}, {0, 600}}];
plot["seLR"]   = Show[plot["1LR"], plot["1L"], plot["1R"], PlotRange->{{100, 640}, {0, 500}}];
plot["smuLR"]  = plot["seLR"];


atlas["CCWW"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_07a.png"];
atlas["CCsl"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_07b.png"];
atlas["slepLR"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/figaux_01.png"];
atlas["slepEM"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/figaux_02.png"];
atlas["seLR"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_08a.png"];
atlas["smuLR"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-32/fig_08b.png"];


PlotOverlay[plot["CCWW"],   atlas["CCWW"], {{400.0, 414.4}, {100, 0}, {53.24, 67.22}, 503.4}]
PlotOverlay[plot["CCsl"],   atlas["CCsl"], {{400.0, 405.1}, {100, 0}, {60.35, 65.37}, 1671.9}]
PlotOverlay[plot["slepLR"], atlas["slepLR"], {{400.0, 405.4}, {100, 0}, {60.35, 65.72}, 797.4}]
PlotOverlay[plot["slepEM"], atlas["slepEM"], {{400.0, 405.4}, {100, 0}, {60.35, 65.72}, 797.4}]
PlotOverlay[plot["seLR"],   atlas["seLR"],   {{400.0, 405.1}, {100, 0}, {60.35, 65.37}, 694.5}]
PlotOverlay[plot["smuLR"],  atlas["smuLR"],  {{400.0, 405.1}, {100, 0}, {60.35, 65.37}, 694.5}]




