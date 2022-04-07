(* ::Package:: *)

(* Time-Stamp: <2022-4-7 13:38:24> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
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


plot["gg"] = ContourPlot[LHCBound["2012.08600-gg"][mg, mn] / theory["gg"][mg], {mg, 1100, 2350}, {mn, 100, 2000}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
plot["WZ"] = ContourPlot[LHCBound["2012.08600-WZ"][m2, m1] / theory["WZ"][m2], {m2, 100, 900}, {m1, 0, 450}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
plot["bb"] = ContourPlot[LHCBound["2012.08600-bb1"][mb, m2] / (theory["sb10"][mb]/10*1), {mb, 800, 1800}, {m2, 200, 1800}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
plot["qq"] = ContourPlot[LHCBound["2012.08600-qq8"][mq, m2] / (theory["sb10"][mq]/10*8), {mq, 1000, 2200}, {m2, 200, 2000}, Contours->{1}, ContourShading->None, ContourStyle->Blue]
plot["ll"] = ContourPlot[LHCBound["2012.08600-ll1LR"][ml, m1] / theory["seLR"][ml], {ml, 100, 1000}, {m1, 0, 600}, Contours->{1}, ContourShading->None, ContourStyle->Blue]


cms["gg"] = Import["https://cds.cern.ch/record/2747744/files/Figure_010.png"];
cms["WZ"] = Import["https://cds.cern.ch/record/2747744/files/Figure_011.png"];
cms["bb"] = Import["https://cds.cern.ch/record/2747744/files/Figure_013-a.png"];
cms["qq"] = Import["https://cds.cern.ch/record/2747744/files/Figure_013-b.png"];
cms["ll"] = Import["https://cds.cern.ch/record/2747744/files/Figure_014.png"];
Show[{ImageResize[Image[plot["gg"]],400],ImageTrim[ImageResize[SetAlphaChannel[cms["gg"], 0.2],{670, 550}],{{194,24},{800,400}}]}]
Show[{ImageResize[Image[plot["WZ"]],400],ImageTrim[ImageResize[SetAlphaChannel[cms["WZ"], 0.2],{670, 560}],{{193,26},{800,400}}]}]
Show[{ImageResize[Image[plot["bb"]],400],ImagePad [ImageResize[SetAlphaChannel[cms["bb"], 0.2],{446, 496}],{{14,0},{2,0}}]}]
Show[{ImageResize[Image[plot["qq"]],400],ImagePad [ImageResize[SetAlphaChannel[cms["qq"], 0.2],{408, 532}],{{19,0},{-5,0}}]}]
Show[{ImageResize[Image[plot["ll"]],400],ImagePad [ImageResize[SetAlphaChannel[cms["ll"], 0.25],{446, 517}],{{13,0},{1,0}}]}]
