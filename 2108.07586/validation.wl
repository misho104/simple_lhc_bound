(* ::Package:: *)

(* Time-Stamp: <2022-04-09 20:33:10> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
LHCBoundInfo["2108.07586"]
LHCBoundUsage["2108.07586-HH/grav"]
LHCBound["2108.07586-HH/grav"][400, 1]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
theory["nnHino"] = Get["13TeV.n1n2.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["ncHino"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["ccHino"] = Get["13TeV.x1x1.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Hino"]   = theory["nnHino"][#] + 2*theory["ncHino"][#] + theory["ccHino"][#] &;
theory["ccWino"] = Get["13TeV.x1x1.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["cnWino"] = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;


SetOptions[ContourPlot, Contours->{1}, ContourShading->None];
plot["grav"] = ContourPlot[LHCBound["2108.07586-HH/grav"]  [mhino, brZ] / theory["Hino"][mhino], {mhino, 400, 1500}, {brZ, 0, 1}]
plot["CCWW"] = ContourPlot[LHCBound["2108.07586-CC/WW"]  [mwino, mLSP] / theory["ccWino"][mwino], {mwino, 400, 1100}, {mLSP, 0, 300}]
plot["CNWZ"] = ContourPlot[LHCBound["2108.07586-CN/WZ"]  [mwino, mLSP] / theory["cnWino"][mwino], {mwino, 400, 1100}, {mLSP, 0, 500}]
plot["CNWH"] = ContourPlot[LHCBound["2108.07586-CN/WH"]  [mwino, mLSP] / theory["cnWino"][mwino], {mwino, 400, 1100}, {mLSP, 0, 500}]


atlas["grav"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_16.png"];
atlas["CCWW"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_15a.png"];
atlas["CNWZ"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_15b.png"];
atlas["CNWH"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_15c.png"];


(* ::Input:: *)
(*GetFrame[atlas["CNWH"]];*)
(*DebugInfo*)
(*FindOverlay[plot["CNWH"], atlas["CNWH"], %%, {300, 1210}, {0, 800}] // InputForm*)


PlotOverlay[plot["CCWW"], atlas["CCWW"], {{400., 520.2}, {350, 0}, {56.31, 74.09}, 1039.2}]
PlotOverlay[plot["grav"], atlas["grav"], {{400., 240.3}, {150, 0}, {56.31, 34.23}, 2356.3}]
PlotOverlay[plot["CNWZ"], atlas["CNWZ"], {{400., 524.4}, {300, 0}, {56.31, 74.68}, 1099.6}]
PlotOverlay[plot["CNWH"], atlas["CNWH"], {{400., 524.4}, {300, 0}, {56.31, 74.68}, 1099.6}]
