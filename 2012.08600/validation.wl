(* ::Package:: *)

(* Time-Stamp: <2022-05-22 19:43:20> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
LHCBoundInfo["2012.08600"]
LHCBoundUsage["2012.08600-ll1LR"]
LHCBound["2012.08600-ll1LR"][300, 50]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["gg"]   = Get["13TeV.gg.decoup.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["WZ"]   = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
(* squark-antisquark pair-production for 10 flavor squarks *)
theory["sb10"] = Get["13TeV.sb10.decoup.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
(* sum of left- and right-handed selectron pair-production *)
theory["seLR"] = Get["13TeV.slepslep.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;


SetOptions[ContourPlot, Contours->{1}, ContourShading->None, ContourStyle->{{Thick, Blue}}];
plot["gg"] = ContourPlot[LHCBound["2012.08600-gg"][mg, mn] / theory["gg"][mg],           {mg, 1100, 2350}, {mn, 100, 2000}];
plot["WZ"] = ContourPlot[LHCBound["2012.08600-WZ"][m2, m1] / theory["WZ"][m2],           {m2,  100,  900}, {m1,   0,  600}];
plot["bb"] = ContourPlot[LHCBound["2012.08600-bb1"][mb, m2] / (theory["sb10"][mb]/10*1), {mb,  800, 1800}, {m2,   0, 2400}];
plot["qq"] = ContourPlot[LHCBound["2012.08600-qq8"][mq, m2] / (theory["sb10"][mq]/10*8), {mq, 1000, 2200}, {m2,   0, 2400}];
plot["ll"] = ContourPlot[LHCBound["2012.08600-ll1LR"][ml, m1] / theory["seLR"][ml],      {ml,  100, 1000}, {m1,   0,  800}];


cms["gg"] = Import["https://cds.cern.ch/record/2747744/files/Figure_010.png"];
cms["WZ"] = Import["https://cds.cern.ch/record/2747744/files/Figure_011.png"];
cms["bb"] = Import["https://cds.cern.ch/record/2747744/files/Figure_013-a.png"];
cms["qq"] = Import["https://cds.cern.ch/record/2747744/files/Figure_013-b.png"];
cms["ll"] = Import["https://cds.cern.ch/record/2747744/files/Figure_014.png"];


PlotOverlay[plot["gg"], cms["gg"], {{400.0, 330.3}, {1100, 100}, {159.4, 58.76}, 2792.8}]
PlotOverlay[plot["WZ"], cms["WZ"], {{400.0, 251.0}, {100, 0}, {159.4, 44.66}, 1787.4}]
PlotOverlay[plot["bb"], cms["bb"], {{400.0, 301.6}, {800, 150}, {54.68, 41.14}, 1484.4}]
PlotOverlay[plot["qq"], cms["qq"], {{400.0, 395.3}, {1000, 150}, {54.39, 53.88}, 1629.2}]
PlotOverlay[plot["ll"], cms["ll"], {{400.0, 342.8}, {100, 0}, {54.71, 46.68}, 1339.3}]



