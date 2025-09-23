Urban Heat Risk Mapping in New York City (2013-2023)
This repository contains the computational code and models used for the manuscript titled "Urban Heat Risk Mapping in New York City Using GIS and Fuzzy AHP-Based Multi-Indicator Analysis," submitted to Computers, Environment and Urban Systems.

Repository Contents
/Code: This directory contains the models used for the analysis.

qgis_graphical_model_final.model3: The QGIS Graphical Modeler file that automates the entire geospatial processing workflow from raw inputs to the final Heat Risk Index (HRI).

Data Availability
Processed and Input Data
All raw input data (boundaries, population) and final processed datasets (annual HRI, LST, and NDVI rasters) associated with this study are permanently archived on Zenodo and are publicly available for download.

Zenodo Repository DOI: https://doi.org/10.5281/zenodo.17186482

Raw Landsat 8 Satellite Imagery
The raw Landsat 8 Level-2 imagery is not included in the Zenodo archive due to its large size. This data is freely available from the USGS.

To acquire the raw satellite data:

Go to the USGS Earth Explorer portal: https://earthexplorer.usgs.gov/

Search for the Landsat 8 Collection 2 Level-2 scenes corresponding to the acquisition dates listed in Table 4 of our manuscript.

How to Reproduce the Analysis
Download Data: Download the Data archive from the Zenodo link provided above. Download the raw Landsat 8 scenes from USGS Earth Explorer.

Set up QGIS: Ensure you have a working installation of QGIS (version 3.16 or later is recommended).

Import the Model: Open the QGIS Graphical Modeler (Processing > Graphical Modeler) and import the qgis_graphical_model_final.model3 file from this repository.

Run the Model: Execute the model, providing the paths to the downloaded raw data when prompted by the model interface. The model will automatically generate all intermediate and final raster files.
