(* ::Package:: *)

(* :Time-Stamp: <2022-5-17 17:38:21> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
LHCBoundInfo["1911.06660"]
LHCBoundUsage["1911.06660-stau"]
LHCBound["1911.06660-stau"][300, 50]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["stau"]   = Get["13TeV.slepslep.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["stauL"]   = Get["13TeV.slepslep.ll.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
plot["stau"] = ContourPlot[LHCBound["1911.06660-stau"][m2, m1] / theory["stau"][m2], {m2, 80, 450}, {m1, 0, 270}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
plot["stauL"] = ContourPlot[LHCBound["1911.06660-stauL"][m2, m1] / theory["stauL"][m2], {m2, 80, 450}, {m1, 0, 270}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
atlas["stau"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-04/fig_07a.png"];
atlas["stauL"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-04/fig_07b.png"];


PlotOverlay[plot["stau"],  atlas["stau"],  {{400,381.4},{80,0},{56.31,39},470.9}]
PlotOverlay[plot["stauL"], atlas["stauL"], {{400,381.4},{80,0},{56.31,39},470.9}]



