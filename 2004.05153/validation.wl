(* ::Package:: *)

(* Time-Stamp: <2022-05-22 15:33:30> *)

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
LHCBoundInfo["2004.05153"]
LHCBoundUsage["2004.05153-Wino"]
LHCBound["2004.05153-Wino"][3.3 * 10^-9, 500]


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
c1c1["Wino"] = Get["13TeV.x1x1.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
n2c1["Wino"] = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
c1c1["Higgsino"] = Get["13TeV.x1x1.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
n2c1["Higgsino"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Wino"] = n2c1["Wino"][#]+c1c1["Wino"][#]&;
theory["Higgsino"] = 2*n2c1["Higgsino"][#]+c1c1["Higgsino"][#]&;


(* check n2c1/c1c1 ratio *)
Plot[{n2c1["Wino"][m] / c1c1["Wino"][m],
      2*n2c1["Higgsino"][m] / c1c1["Higgsino"][m]}, {m, 100, 1100}]


plot["W"] = ContourPlot[LHCBound["2004.05153-Wino"    ][10^t, m] / theory["Wino"    ][m], {m, 100, 1150}, {t, Log10[0.02*^-9], Log10[350*^-9]}, Contours->{1}, ContourShading->None, FrameTicks->{{FakeLog10Ticks, None}, {LinTicks, None}}];
plot["H"] = ContourPlot[LHCBound["2004.05153-Higgsino"][10^t, m] / theory["Higgsino"][m], {m, 100,  950}, {t, Log10[0.02*^-9], Log10[350*^-9]}, Contours->{1}, ContourShading->None, FrameTicks->{{FakeLog10Ticks, None}, {LinTicks, None}}];
cms["W"] = Import["http://cms-results.web.cern.ch/cms-results/public-results/publications/EXO-19-010/CMS-EXO-19-010_Figure_002.png"];
cms["H"] = Import["http://cms-results.web.cern.ch/cms-results/public-results/publications/EXO-19-010/CMS-EXO-19-010_Figure_003.png"];


PlotOverlay[plot["W"], cms["W"], {{400., 401.7}, {100, -10.7}, {56.72, 46.37}, 1274.3}]
PlotOverlay[plot["H"], cms["H"], {{400., 401.7}, {100, -10.7}, {56.72, 46.37}, 1031.6}]
(* the Higgsino plot does not match Fig. 3 of 2004.05153v2;
   Sho thinks that the Fig. 3 or the HEPData set for Higgsinos are errneous; see the following comparisons with CMS's additional figures. *)


(* Wino plot: in good agreements *)
Show[{
  ImageResize[LogPlot[{LHCBound["2004.05153-Wino"][0.33*^-9, m], theory["Wino"][m]}, {m, 100, 1100}, PlotStyle->{{Blue, Thick, Dashed}}][[1]], 400],
  ImagePad[ImageResize[SetAlphaChannel[Import["http://cms-results.web.cern.ch/cms-results/public-results/publications/EXO-19-010/CMS-EXO-19-010_Figure_001-a.png"], 0.5],{365, 298}],{{23,0},{40,0}}]
}]
Show[{
  ImageResize[LogPlot[{LHCBound["2004.05153-Wino"][333*^-9, m], theory["Wino"][m]}, {m, 100, 1100}, PlotStyle->{{Blue, Thick, Dashed}}][[1]], 400],
  ImagePad[ImageResize[SetAlphaChannel[Import["http://cms-results.web.cern.ch/cms-results/public-results/publications/EXO-19-010/CMS-EXO-19-010_Figure_001-d.png"], 0.5],{365, 298}],{{23,0},{40,0}}]
}]
(* Higgsino Plot: agreeing in 1D-plots but not in the 2D-plot. *)
Show[{
  ImageResize[LogPlot[{LHCBound["2004.05153-Higgsino"][0.33*^-9, m], theory["Higgsino"][m]}, {m, 100, 900}, PlotStyle->{{Blue, Thick, Dashed}}][[1]], 400],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://www.hepdata.net/record/resource/2231509?view=true"], 0.5],{365, 346}],{{23,0},{25,0}}]
}]
Show[{
  ImageResize[LogPlot[{LHCBound["2004.05153-Higgsino"][3.34*^-9, m], theory["Higgsino"][m]}, {m, 100, 900}, PlotStyle->{{Blue, Thick, Dashed}}][[1]], 400],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://www.hepdata.net/record/resource/2231512?view=true"], 0.5],{365, 346}],{{23,0},{25,0}}]
}]
Show[{
  ImageResize[LogPlot[{LHCBound["2004.05153-Higgsino"][333*^-9, m], theory["Higgsino"][m]}, {m, 100, 900}, PlotStyle->{{Blue, Thick, Dashed}}][[1]], 400],
  ImagePad[ImageResize[SetAlphaChannel[Import["https://www.hepdata.net/record/resource/2231518?view=true"], 0.5],{365, 346}],{{23,0},{25,0}}]
}]
