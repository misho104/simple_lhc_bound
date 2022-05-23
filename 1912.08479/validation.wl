(* ::Package:: *)

(* :Time-Stamp: <2022-5-21 21:06:07> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
LHCBoundInfo["1912.08479"]
LHCBoundUsage["1912.08479-CN/WZ"]
LHCBound["1912.08479-CN/WZ"][200, 100]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["NC"]   = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
plot["WZ"] = ContourPlot[LHCBound["1912.08479-CN/WZ"][m2, m1] / theory["NC"][m2], {m2, 100, 500}, {m1, 0, 300}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
atlas["WZ"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-06/fig_07.png"];


PlotOverlay[plot["WZ"], atlas["WZ"], {{400., 351.2}, {100, 0}, {80.16, 35.96}, 550.9}]



