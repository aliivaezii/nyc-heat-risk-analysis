# Urban Heat Risk Mapping in New York City (2013-2023)

This repository contains the computational code and models for the manuscript titled "Urban Heat Risk Mapping in New York City Using GIS and Fuzzy AHP-Based Multi-Indicator Analysis," submitted to Computers, Environment and Urban Systems.

## Repository Contents

* **/Code**: This directory contains the models used for the analysis.
    * **qgis\_graphical\_model\_final.model3**: The QGIS Graphical Modeler file that automates the entire geospatial processing workflow.
    * **fuzzy\_ahp\_weights.gms**: The GAMS (General Algebraic Modeling System) code that implements the Fuzzy AHP method to calculate the indicator weights.

## Data Availability

### Processed and Input Data

All raw input data (boundaries, population) and final processed datasets (annual HRI, LST, and NDVI rasters) associated with this study are permanently archived on Zenodo and are publicly available for download.

* **Zenodo Repository DOI**: https://doi.org/10.5281/zenodo.17186482

### Raw Landsat 8 Satellite Imagery

The raw Landsat 8 Level-2 imagery is not included in the Zenodo archive due to its large size. This data is freely available from the USGS Earth Explorer portal: https://earthexplorer.usgs.gov/. Please refer to Table 4 in the manuscript for the specific acquisition dates.

## How to Reproduce the Analysis

The analysis consists of two main parts: (1) calculating the indicator weights using GAMS, and (2) generating the HRI maps using QGIS.

### 1. Indicator Weight Calculation (GAMS)

* **Prerequisites**: A working installation of GAMS.
* **Execution**: Run the `fuzzy_ahp_weights.gms` file from the `/Code` directory using GAMS. This will replicate the weight calculation and consistency analysis presented in the manuscript.

### 2. HRI Map Generation (QGIS)

1.  **Download Data**: Download the necessary data archives from the Zenodo link provided above and the raw Landsat 8 scenes from USGS Earth Explorer.
2.  **Set up QGIS**: Ensure you have a working installation of QGIS (version 3.16 or later is recommended).
3.  **Import the Model**: Open the QGIS Graphical Modeler (Processing > Graphical Modeler) and import the `qgis_graphical_model_final.model3` file.
4.  **Run the Model**: Execute the model, providing the paths to the downloaded raw data when prompted. The model will automatically generate all required raster files.
