(* ::Package:: *)

(* :Time-Stamp: <2022-5-28 20:07:51> *)


If[$FrontEnd =!= Null, SetDirectory[NotebookDirectory[]]];
$Path = Append[$Path, ParentDirectory[]]//DeleteDuplicates;


Get["../contrib/PlotTools.wl"];
<<SimpleLHCBound`
<<SimpleLHCBoundValidator`
SimpleLHCBound`Private`$Debug=True;
SimpleLHCBoundValidator`Private`$OutputPDF = ($FrontEnd === Null);
LHCBoundInfo["2106.01676"]
LHCBoundUsage["2106.01676-WinoOppo/WZ"]
LHCBound["2106.01676-WinoOppo/WZ"][200, 182]


atlas["WinoPara/WZ-1"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/fig_16a.png"];
atlas["WinoPara/WZ-2"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/fig_16b.png"];
atlas["WinoOppo/WZ"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/fig_16c.png"];
atlas["Higgsino/WZ"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/fig_16d.png"];
atlas["WinoPara/WH"] = Import["https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2019-09/fig_17.png"];


(* if "xs" files are not found,
   double-check you have done "make dev", which calls "susy-xs" package to prepare cross section data. *)
GeV = fb = 1;
pb = 1000fb;
theory["Wino"] = Get["13TeV.n2x1+-.wino.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;
theory["Hino"] = Get["13TeV.n2x1+-.hino.deg.xs"][[2;;]] // SimpleLHCBound`Private`IP["Log>Log", #, InterpolationOrder->4]&;

SetOptions[ContourPlot, Contours->{1}, ContourShading->None, ContourStyle->{{Thick, Blue}}];
plot["WinoPara/WZ-1"] = ContourPlot[LHCBound["2106.01676-WinoPara/WZ"][m2, m1] / theory["Wino"][m2], {m2, 100, 800}, {m1, 0, 600}, Contours->{1}];
plot["WinoPara/WZ-2"] = ContourPlot[LHCBound["2106.01676-WinoPara/WZ"][m2, m2-\[CapitalDelta]m] / theory["Wino"][m2], {m2, 100, 500}, {\[CapitalDelta]m, 0, 250}, Contours->{1}] // Show[#, ListPlot[{#[[1]], #[[1]]-#[[2]]} &/@ LHCBoundTable["2106.01676-WinoPara/WZ"]]]&;
plot["WinoOppo/WZ"]   = ContourPlot[LHCBound["2106.01676-WinoOppo/WZ"][m2, m2-\[CapitalDelta]m] / theory["Wino"][m2], {m2, 100, 500}, {\[CapitalDelta]m, 0, 180}, Contours->{1}] // Show[#, ListPlot[{#[[1]], #[[1]]-#[[2]]} &/@ LHCBoundTable["2106.01676-WinoOppo/WZ"]]]&;
plot["Higgsino/WZ"]   = ContourPlot[LHCBound["2106.01676-Higgsino/WZ"][m2, m2-\[CapitalDelta]m] / theory["Hino"][m2], {m2, 100, 300}, {\[CapitalDelta]m, 0, 120}, Contours->{1}] // Show[#, ListPlot[{#[[1]], #[[1]]-#[[2]]} &/@ LHCBoundTable["2106.01676-Higgsino/WZ"]]]&;
plot["WinoPara/WH"]   = ContourPlot[LHCBound["2106.01676-WinoPara/WH"][m2, m2-\[CapitalDelta]m] / theory["Wino"][m2], {m2, 145, 320}, {\[CapitalDelta]m, 0, 160}, Contours->{1}] // Show[#, ListPlot[{#[[1]], #[[1]]-#[[2]]} &/@ LHCBoundTable["2106.01676-WinoPara/WH"]]]&;


(* difference in Higgsino plot is due to the fact that we incorrectly use higgsino cross section with N2=C1 *)
PlotOverlay[plot["WinoPara/WZ-1"], atlas["WinoPara/WZ-1"], {{400.0, 401.9}, {100, 0}, {56.31, 57.24}, 888.7}]
PlotOverlay[plot["WinoPara/WZ-2"], atlas["WinoPara/WZ-2"], {{400.0, 401.9}, {100, 0}, {56.31, 57.24}, 507.8}]
PlotOverlay[plot["WinoOppo/WZ"],   atlas["WinoOppo/WZ"],   {{400.0, 268.2}, {100, 0}, {56.31, 38.19}, 507.8}]
PlotOverlay[plot["Higgsino/WZ"], atlas["Higgsino/WZ"], {{400.0, 200.2}, {100, 0}, {56.31, 28.52}, 253.9}]
PlotOverlay[plot["WinoPara/WH"], atlas["WinoPara/WH"], {{400.0, 404.5}, {145, 0}, {60.38, 61.27}, 225.7}]



