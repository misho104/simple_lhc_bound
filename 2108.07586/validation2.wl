(* ::Package:: *)

(* Time-Stamp: <2022-05-22 20:29:28> *)

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
LHCBoundInfo["2108.07586"]
LHCBoundUsage["2108.07586-Fig12-WB"]
LHCBoundTable["2108.07586-Fig12-HB"];


plot["Fig12"] = ContourPlot[None, {x, 250, 1210}, {y, 0, 800}, Epilog->Join[
    Flatten[{Red, Thick, Dashed, Opacity[0.2+#[[1]]*0.4], #[[2]]}&/@LHCBoundTable["2108.07586-Fig12-WB"]],
    Flatten[{Blue, Thick, Dashed, Opacity[0.2+#[[1]]*0.4], #[[2]]}&/@LHCBoundTable["2108.07586-Fig12-HB"]]
  ]]
atlas["Fig12"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_12b.png"];
PlotOverlay[plot["Fig12"], atlas["Fig12"], {{400., 426.1}, {250, 0}, {56.31, 60.68}, 1160.}, "alpha"->0.6]


plot["Fig17"] = ContourPlot[None, {x, 250, 1210}, {y, 0, 800}, Epilog->Join[
    Flatten[{Dashed, Opacity[0.2+#[[1]]*0.4], #[[2]]}&/@LHCBoundTable["2108.07586-Fig17"]]
  ]]
atlas["Fig17"] = Import["http://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-41/fig_17b.png"];
PlotOverlay[plot["Fig17"], atlas["Fig17"], {{400., 426.1}, {250, 0}, {56.31, 60.68}, 1160.}, "alpha"->0.3]


(* sample usage: for fixed (m_chargino, m_LSP) with pure-wino cross section
   positive means allowed, negative means excluded.
*)
distance = {#[[1]], SignedRegionDistance[#[[2]], {1000, 400}]} &/@ (LHCBoundTable["2108.07586-Fig12-WB"]/.{Line->Polygon});
ListLinePlot[distance]
(* Higgsino-like case can be non-trivial *)
distance = {#[[1]], SignedRegionDistance[#[[2]], {700, 250}]} &/@ (LHCBoundTable["2108.07586-Fig12-HB"]/.{Line->Polygon});
ListLinePlot[distance]


(* sample usage: interpolation between WB and HB *)
distance = Join[
  {1, #[[1]], SignedRegionDistance[#[[2]], {1000, 200}]} &/@ (LHCBoundTable["2108.07586-Fig12-WB"]/.{Line->Polygon}),
  {0, #[[1]], SignedRegionDistance[#[[2]], {1000, 200}]} &/@ (LHCBoundTable["2108.07586-Fig12-HB"]/.{Line->Polygon})
]
Table[{winolike/.FindRoot[Interpolation[distance][winolike,brZ]==0,{winolike, 0, 1}], brZ}, {brZ, 0, 1, 0.02}]
Show[ListPlot3D[distance, AxesLabel->{"winolike", "brZ"}], ListPointPlot3D[distance], ListPointPlot3D[{#[[1]], #[[2]], 0}&/@%], Plot3D[0, {x, 0, 1}, {y, 0, 1}]]



