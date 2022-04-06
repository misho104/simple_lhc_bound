(* ::Package:: *)

(* Time-Stamp: <2022-4-6 18:07:31> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
LHCBoundInfo["2201.02472"]
LHCBoundUsage["2201.02472-Wino"]
LHCBound["2201.02472-Wino"][0.2 * 10^-9, 400]
LHCBound["2201.02472-Higgsino"][0.2 * 10^-9, 400]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
c1c1["Wino"] = Get["13TeV.x1x1.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
n2c1["Wino"] = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
c1c1["Higgsino"] = Get["13TeV.x1x1.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
n2c1["Higgsino"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Wino"] = n2c1["Wino"][#]+c1c1["Wino"][#]&;
theory["Higgsino"] = 2*n2c1["Higgsino"][#]+c1c1["Higgsino"][#]&;


WinoPlot = ContourPlot[LHCBound["2201.02472-Wino"][10^t, m] / theory["Wino"][m], {m, 90, 1000}, {t, -11, -8}, Contours->{1}, ContourShading->None]
HinoPlot = ContourPlot[LHCBound["2201.02472-Higgsino"][10^t, m] / theory["Higgsino"][m], {m, 90, 1000}, {t, -11, -8}, Contours->{1},ContourShading->None]


ATLW = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/fig_07.png"];
ATLH = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-19/fig_08a.png"];


(* ::Text:: *)
(*The results are not in good agreement. The difference corresponds to 30\[Dash]40% in the cross section.*)
(*Sho could not find the origin of this difference.*)
(*Note that this program relies on the value "0.037 fb" in Table 8 of the article as the 95%-CL upper bound.*)


Show[{ImageResize[Image[WinoPlot],400],ImageCrop[ImageResize[SetAlphaChannel[ATLW, 0.2],{355, 377}],{433,451}]}]
Show[{ImageResize[Image[HinoPlot],400],ImageCrop[ImageResize[SetAlphaChannel[ATLH, 0.2],{372, 377}],{418,451}]}]



