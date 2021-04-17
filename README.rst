Simple LHC bound
================

A Mathematica/Python tool to reinterpret LHC_ constraints.

This repository collects data files for recent constraints provided by LHC_ experiments and provides small tools to use the data.

- We generally use ``GeV``, ``fb``, ``m``, and ``s`` in analysis codes.
- Preliminary results are usually not included.
- Contributions are welcome.


Usage
-----

First, execute ``make`` in this directory (for some preparations).
Then one can call, from Mathematica,

.. code-block:: wolfram

   AppendTo[$Path, (path to SimpleLHCBound.m)];
   <<SimpleLHCBound`;
   LHCBoundInfo["xxxx.yyyyy"]
   LHCBoundUsage["xxxxx.yyyy-NAME"]
   LHCBound["xxxxx.yyyyy-NAME"][m1, m2]


License
-------

This code set ("software") is licensed to you under |Apache2|_.
See ``LICENSE`` file and ``NOTICE`` file for further information.


License of data files
~~~~~~~~~~~~~~~~~~~~~

This software contains data from ATLAS_ and CMS_ collaborations.
Original source locations and licenses for data files are provided in ``README.rst`` file in each directory.

- Usually, data files published on `HEPData`_ are licensed under `CC0`_ License.
  See https://www.hepdata.net/terms .
- CMS_ collaboration sometimes provides their data as root files (example: `CMS-SUS-19-011 <http://cms-results.web.cern.ch/cms-results/public-results/publications/SUS-19-011/index.html>`_), while to my knowledge the root files are not under any explicit licenses.


How to Use & Cite
-----------------
See ``README.md`` in each directory.


.. |Apache2| replace:: the Apache License, version 2.0
.. _Apache2: https://www.apache.org/licenses/LICENSE-2.0
.. _CC0: https://creativecommons.org/publicdomain/zero/1.0/legalcode

.. _ATLAS: https://atlas.cern/
.. _CMS:   https://cms.cern/
.. _LHC:   https://lhc.cern/
.. _HEPData: https://www.hepdata.net/
