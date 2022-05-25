(* ::Package:: *)

(* :Time-Stamp: <2022-5-26 15:58:52> *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
LHCBoundInfo["2004.10894"]
LHCBoundUsage["2004.10894-CN/WH"]
LHCBound["2004.10894-CN/WH"][300, 50]


atlas["0.5"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-23/fig_09.png"];
atlas["Wino"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-23/fig_10.png"];
atlas["HinoGrav"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-23/fig_11a.png"];


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["Wino"]   = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoNC"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoNN"] = Get["13TeV.n1n2.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["HinoCC"] = Get["13TeV.x1x1.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Hino"]   = (2*theory["HinoNC"][#] + theory["HinoNN"][#] + theory["HinoCC"][#])&;

plot["Wino"] = RegionPlot[LHCBound["2004.10894-CN/WH"][m2, m1] < theory["Wino"][m2], {m2, 150, 400}, {m1, 0, 300}, PlotLegends->False];
plot["0.5"] = LogPlot[{
  theory["Wino"][m2],
  LHCBound["2004.10894-CN/WH"][m2, 0.5]
}, {m2, 150, 600}, PlotRange->{{150, 600}, {10, 10^4}}, PlotLegends->None];
plot["HinoGrav"] = LogPlot[{
  theory["Hino"][m2],
  LHCBound["2004.10894-HiggsinoGrav"][m2, 0.5]
}, {m2, 100, 800}, PlotRange->{{100, 800}, {1, 10^5}}, PlotLegends->None];


PlotOverlay[plot["Wino"], atlas["Wino"], {{400, 325.1}, {120, 0}, {64.28, 42.79}, 395.8}]
PlotOverlay[plot["0.5"], atlas["0.5"], {{400.0, 479.7}, {128, 2.30259}, {64.28, 72.83}, 611.4}]
PlotOverlay[plot["HinoGrav"], atlas["HinoGrav"], {{400.0, 351.8}, {97, 0}, {64.28, 53.4}, 913.4}]



