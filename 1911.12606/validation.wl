(* ::Package:: *)

(* :Time-Stamp: <2022-5-23 11:25:50> *)

(* Copyright 2022 Sho Iwamoto / Misho
   This file is licensed under the Apache License, Version 2.0.
   You may not use this file except in compliance with it. *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Print["Note for 1911.12606-Validation:
Validation for Wino VBF result (Fig. 43ab), which needs cross-section data, is not provided."]

Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug = True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
LHCBoundInfo["1911.12606"]
LHCBoundUsage["1911.12606-WinoPara"]
LHCBound["1911.12606-WinoPara"][600, 10]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["Wino"]   = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoNC"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoNN"] = Get["13TeV.n1n2.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoCC"] = Get["13TeV.x1x1.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Hino"]   = (theory["HinoNC"][#] + theory["HinoNN"][#] + theory["HinoCC"][#])&;
theory["SelLR"]  = Get["13TeV.slepslep.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["SelL"]   = Get["13TeV.slepslep.ll.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["SelR"]   = Get["13TeV.slepslep.rr.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["SmuLR"] := theory["SelLR"]
theory["SmuL"]  := theory["SelL"]
theory["SmuR"]  := theory["SelR"]
theory["SlepLR"] = (theory["SelLR"][#]*2)&;
theory["SlepL"]  = (theory["SelL"][#]*2)&;
theory["SlepR"]  = (theory["SelR"][#]*2)&;


atlas["WinoPara"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/fig_14c.png"];
atlas["WinoOppo"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/fig_14b.png"];
atlas["Hino"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/fig_14a.png"];
atlas["SlepLR"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/fig_16a.png"];
atlas["SlepL"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/figaux_44c.png"];
atlas["SlepR"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/figaux_44e.png"];
atlas["SelLR"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/figaux_46a.png"];
atlas["SmuLR"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/figaux_45a.png"];
atlas["Semu"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-16/fig_16b.png"];
SetOptions[ContourPlot, Contours->{1}, ContourShading->None, ContourStyle->{{Thick, Blue}}, FrameTicks->{{FakeLog10Ticks, None}, Automatic}];


(* 
  The Higgsino plot has a discrepancy in the larger \[CapitalDelta]m region, which seems to originate in the difference of cross section;
  this validation uses the cross section with N1=N2=C1.
  Note that this analysis requires 2 lepton plus 1 jet signature (Table 2), which is provided only by N2C1 process.
  N2N1 and C1C1 process will not contribute to the signal events anyway.
*)
plot["WinoPara"] = ContourPlot[LHCBound["1911.12606-WinoPara"][m2, 10^dm] / theory["Wino"][m2], {m2, 80, 400}, {dm, Log10[0.5], Log10[80]}];
plot["WinoOppo"] = ContourPlot[LHCBound["1911.12606-WinoOppo"][m2, 10^dm] / theory["Wino"][m2], {m2, 80, 400}, {dm, Log10[0.5], Log10[80]}];
plot["Hino"]     = ContourPlot[LHCBound["1911.12606-Hino"][m2, 10^dm] / theory["Hino"][m2], {m2, 60, 350}, {dm, Log10[0.8], Log10[80]}];
PlotOverlay[plot["WinoPara"], atlas["WinoPara"], {{400.0, 409.4}, {80, -0.3010299172477932`}, {49.97, 68.94}, 377.1}]
PlotOverlay[plot["WinoOppo"], atlas["WinoOppo"], {{400.0, 409.4}, {80, -0.3010299172477932`}, {49.97, 68.94}, 377.1}]
PlotOverlay[plot["Hino"], atlas["Hino"], {{400.0, 407.2}, {60, -0.09691020786981921`}, {46.71, 68.4}, 338.5}]


(* ::InheritFromParent:: *)
(**)


plot["SlepLR"] = ContourPlot[LHCBound["1911.12606-SlepLR"][msl, 10^dm] / theory["SlepLR"][msl], {msl, 60, 400}, {dm, Log10[0.3], Log10[60]}];
plot["SlepL"] = ContourPlot[LHCBound["1911.12606-SlepL"][msl, 10^dm] / theory["SlepL"][msl], {msl, 50, 400}, {dm, Log10[0.3], Log10[60]}];
plot["SlepR"] = ContourPlot[LHCBound["1911.12606-SlepR"][msl, 10^dm] / theory["SlepR"][msl], {msl, 50, 400}, {dm, Log10[0.3], Log10[60]}];


PlotOverlay[plot["SlepLR"], atlas["SlepLR"], {{400.0, 408.8}, {60, -0.522879}, {50.36, 68.66}, 401.1}]
PlotOverlay[plot["SlepL"], atlas["SlepL"], {{400.0, 407.2}, {50, -0.522879}, {50.36, 67.15}, 412.9}]
PlotOverlay[plot["SlepR"], atlas["SlepR"], {{400.0, 407.2}, {50, -0.522879}, {50.36, 67.15}, 412.9}]


plot["SelLR"] = ContourPlot[LHCBound["1911.12606-SelLR"][msl, 10^dm] / theory["SelLR"][msl], {msl, 50, 400}, {dm, Log10[0.3], Log10[60]}];
plot["SmuLR"] = ContourPlot[LHCBound["1911.12606-SmuLR"][msl, 10^dm] / theory["SmuLR"][msl], {msl, 50, 400}, {dm, Log10[0.3], Log10[60]}];
plot["SelL"] = ContourPlot[LHCBound["1911.12606-SelL"][msl, 10^dm] / theory["SelL"][msl], {msl, 50, 300}, {dm, Log10[0.3], Log10[60]}, ContourStyle->{{Blue, Thick}}];
plot["SelR"] = ContourPlot[LHCBound["1911.12606-SelR"][msl, 10^dm] / theory["SelR"][msl], {msl, 50, 300}, {dm, Log10[0.3], Log10[60]}, ContourStyle->{{Blue, Thick, Dashed}}];
plot["SmuL"] = ContourPlot[LHCBound["1911.12606-SmuL"][msl, 10^dm] / theory["SmuL"][msl], {msl, 50, 300}, {dm, Log10[0.3], Log10[60]}, ContourStyle->{{Green, Thick}}];
plot["SmuR"] = ContourPlot[LHCBound["1911.12606-SmuR"][msl, 10^dm] / theory["SmuR"][msl], {msl, 50, 300}, {dm, Log10[0.3], Log10[60]}, ContourStyle->{{Green, Thick, Dashed}}];
plot["Semu"] = Show[plot/@{"SelL", "SelR", "SmuL", "SmuR"}];


PlotOverlay[plot["SelLR"], atlas["SelLR"], {{400.0, 404.8}, {50, -0.522879}, {49.97, 64.44}, 412.4}]
PlotOverlay[plot["SmuLR"], atlas["SmuLR"], {{400.0, 404.8}, {50, -0.522879}, {49.97, 64.44}, 412.4}]
PlotOverlay[plot["Semu"], atlas["Semu"], {{400.0, 409.0}, {50, -0.522879}, {50.36, 68.92}, 294.9}]



