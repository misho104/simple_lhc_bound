#!env python3
# Time-Stamp: <2021-04-20 19:12:36>

# Copyright 2021 Sho Iwamoto / Misho
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import ctypes
import typing
import logging
import pathlib
import sys

import ROOT

logger = logging.getLogger(__name__)
gc_protection = []  # storage to avoid garbage collection


def list_primitives(f: ROOT.TFile) -> typing.List[str]:
    results = []
    for key in f.GetListOfKeys():
        obj = f.Get(key.GetName())
        results.append(repr(obj))
        if isinstance(obj, ROOT.TVirtualPad):
            for primitive in obj.GetListOfPrimitives():
                results.append("  " + repr(primitive))
    return results


def get_hist(path: pathlib.Path, name: str) -> ROOT.TObject:
    f = ROOT.TFile(str(path))
    gc_protection.append(f)

    # look for normal object
    if obj := f.Get(name):
        return obj

    # look for primitive object
    for key in f.GetListOfKeys():
        obj = f.Get(key.GetName())
        try:
            primitive = obj.GetPrimitive(name)
            if primitive:
                return primitive
        except Exception:
            pass

    logger.critical(f"Object {name} not found")
    logger.info("Following objects and primitive objects are found.")
    for line in list_primitives(f):
        logger.info(line)
    exit(1)


def show(path: pathlib.Path, name: str) -> None:
    hist = get_hist(path, name)
    if hist.ClassName() in ["TH2F", "TH2D"]:
        (ix, iy, iz) = [ctypes.c_int(-1) for p in range(3)]
        for i in range(0, hist.fN):
            hist.GetBinXYZ(i, ix, iy, iz)
            x = hist.GetXaxis().GetBinCenter(ix.value)  # assuming "center"...
            y = hist.GetYaxis().GetBinCenter(iy.value)
            print(f"{x}, {y}, {hist.GetBinContent(i)}")


if __name__ == "__main__":
    if len(sys.argv) == 3:
        path, name = pathlib.Path(sys.argv[1]), sys.argv[2]
        if path.exists() and name:
            show(path, name)
            exit(0)

    logger.critical(f"Usage: {sys.argv[0]} root_file_path hist_name")
    exit(1)
