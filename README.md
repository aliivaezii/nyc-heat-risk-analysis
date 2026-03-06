# Urban Heat Risk Mapping in New York City (2013-2023)

[![GAMS](https://img.shields.io/badge/GAMS-Fuzzy%20AHP-blue.svg)](https://www.gams.com/)
[![QGIS](https://img.shields.io/badge/QGIS-Graphical%20Modeler-green.svg)](https://qgis.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![DOI](https://img.shields.io/badge/Data-Zenodo-blue.svg)](https://doi.org/10.5281/zenodo.17186482)

> Multi-indicator urban heat risk mapping using GIS, Fuzzy AHP, and Landsat 8 satellite imagery.

---

## Table of Contents

- [Overview](#overview)
- [Repository Contents](#repository-contents)
- [Data Availability](#data-availability)
- [How to Reproduce](#how-to-reproduce)
- [Citation](#citation)
- [License](#license)

---

## Overview

This repository contains the computational code and models for the study **"Urban Heat Risk Mapping in New York City Using GIS and Fuzzy AHP-Based Multi-Indicator Analysis"**, submitted to *Computers, Environment and Urban Systems*.

The analysis combines:
- **Fuzzy AHP** for multi-criteria indicator weight calculation
- **QGIS Graphical Modeler** for automated geospatial processing
- **Landsat 8 Level-2 imagery** for Land Surface Temperature (LST) and NDVI extraction
- **Heat Risk Index (HRI)** mapping across NYC boroughs (2013-2023)

---

## Repository Contents

```
.
├── Code/
│   ├── fuzzy_ahp_weights.gms           # GAMS: Fuzzy AHP weight calculation
│   └── qgis_graphical_model_final.model3  # QGIS: Geospatial processing workflow
├── CITATION.cff
├── LICENSE
└── README.md
```

---

## Data Availability

### Processed and Input Data

All raw input data (boundaries, population) and final processed datasets (annual HRI, LST, and NDVI rasters) are permanently archived on Zenodo:

**Zenodo Repository:** [https://doi.org/10.5281/zenodo.17186482](https://doi.org/10.5281/zenodo.17186482)

### Raw Landsat 8 Satellite Imagery

Raw Landsat 8 Level-2 imagery is freely available from the [USGS Earth Explorer](https://earthexplorer.usgs.gov/). Refer to Table 4 in the manuscript for specific acquisition dates.

---

## How to Reproduce

### 1. Indicator Weight Calculation (GAMS)

- **Prerequisites:** Working installation of [GAMS](https://www.gams.com/).
- **Run:** Execute `Code/fuzzy_ahp_weights.gms` to replicate the weight calculation and consistency analysis.

### 2. HRI Map Generation (QGIS)

1. Download data from the Zenodo link above and raw Landsat 8 scenes from USGS Earth Explorer.
2. Open QGIS (version 3.16 or later).
3. Import the model: **Processing > Graphical Modeler > Open** `Code/qgis_graphical_model_final.model3`.
4. Run the model, providing paths to the downloaded data when prompted.

---

## Citation

If you use this code or data, please cite:

```bibtex
@software{vaezi2025nyc_heat,
  title  = {Urban Heat Risk Mapping in NYC Using GIS and Fuzzy AHP},
  author = {Vaezi, Ali},
  year   = {2025},
  url    = {https://github.com/aliivaezii/nyc-heat-risk-analysis},
  doi    = {10.5281/zenodo.17186482}
}
```

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
