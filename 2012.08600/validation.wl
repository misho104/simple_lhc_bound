(* ::Package:: *)

(* Time-Stamp: <2021-4-20 20:28:15> *)

(* Copyright 2021 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


SetDirectory[NotebookDirectory[]];
$Path = Append[$Path, ParentDirectory[NotebookDirectory[]]]//DeleteDuplicates;


Get["../contrib/PlotTools.m"];
<<SimpleLHCBound`
LHCBoundInfo["2012.08600"]
LHCBoundUsage["2012.08600-ll"]
LHCBound["2012.08600-ll"][300, 50]


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


ContourPlot[LHCBound["2012.08600-gg"][mg, mn] / theory["gg"][mg], {mg, 1100, 2350}, {mn, 100, 2000}, Contours->{1}, ContourShading->None]
ContourPlot[LHCBound["2012.08600-WZ"][m2, m1] / theory["WZ"][m2], {m2, 100, 900}, {m1, 0, 450}, Contours->{1}, ContourShading->None]
ContourPlot[LHCBound["2012.08600-bb"][mb, m2] / (theory["sb10"][mb]/10), {mb, 800, 1800}, {m2, 200, 1800}, Contours->{1}, ContourShading->None]
ContourPlot[LHCBound["2012.08600-qq"][mq, m2] / (theory["sb10"][mq]/10*8), {mq, 1000, 2200}, {m2, 200, 2000}, Contours->{1}, ContourShading->None]
ContourPlot[LHCBound["2012.08600-ll"][ml, m1] / theory["seLR"][ml], {ml, 100, 1000}, {m1, 0, 600}, Contours->{1}, ContourShading->None]
