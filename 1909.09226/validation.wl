(* ::Package:: *)

(* :Time-Stamp: <2022-5-19 12:33:30> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
LHCBoundInfo["1909.09226"]
LHCBoundUsage["1909.09226-CN/WH"]
LHCBound["1909.09226-CN/WH"][300, 50]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["NC"]   = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
plot["WH"] = ContourPlot[LHCBound["1909.09226-CN/WH"][m2, m1] / theory["NC"][m2], {m2, 150, 1080}, {m1, 0, 500}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
atlas["WH"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-08/figaux_03.png"];


PlotOverlay[plot["WH"], atlas["WH"], {{400,379},{150,0},{80.33,61.32},1279}]
