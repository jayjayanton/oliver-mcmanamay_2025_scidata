[![DOI](https://zenodo.org/badge/265254045.svg)](https://zenodo.org/doi/10.5281/zenodo.10442485)

<!-- Get rid of the metarepo instructions (the two sections below this) once you're done. -->

# metarepo
## [Check out the website for instructions](https://immm-sfa.github.io/metarepo)

## Purpose
A meta-repository creates a single point of access for someone to find all of the components that were used to create a published work for the purpose of reproducibility. This repository should contain references to all minted data and software as well as any ancillary code used to transform the source data, create figures for your publication, conduct the experiment, and / or execute the contributing software.

<!-- Get rid of the metarepo instructions (the two sections above this) once you're done. -->

# Oliver&McManamay_2025_ScientificData

**United States multi-sector land use and land cover base maps to support human and Earth system models 10.1038/s41597-025-04713-6**

Jay Oliver<sup>1\*</sup> and Ryan McManamay<sup>1</sup>

<sup>1 </sup>Department of Environmental Science, Baylor University, Waco, TX, USA

\* corresponding author:  Ryan_McManamay@baylor.edu

## Abstract
Earth System Models (ESMs) require current and future projections of land use and landcover change (LULC) to simulate land-atmospheric interactions and global biogeochemical cycles. Among the most utilized land systems in ESMs are the Community Land Model (CLM) and the Land-Use Harmonization 2 (LUH2) products. Regional studies also use these products by extending coarse projections to finer resolutions via downscaling or by using other Multisector Dynamic (MSD) models. One such MSD is the Global Change Analysis Model (GCAM), which has its own independent land model, but often relies on CLM or LUH2 as spatial inputs for its base years. However, this requires harmonization of thematically incongruent land systems at multiple spatial resolutions, leading to uncertainty and error propagation. To resolve these issues, we develop a thematically consistent LULC system for the conterminous United States adaptable to multiple MSD frameworks to support research at a regional level.  Using empirically derived spatial products, we developed a series of base maps for multiple contemporary years of observation at a 30-m resolution that support flexibility and interchangeability amongst LUH2, CLM, and GCAM classification systems. 

## Journal reference
Scientific Data

## Code reference

Oliver, J., R.A. McManamay. 2025. United States Multi-Sector Dynamics land use and land cover base maps to support Human-Earth System Modeling. [IMMM-SFA GitHub Repository] (https://github.com/IMMM-SFA/MSD-Landuse-Basemap-Series/) 

## Data reference

### Input data

Homer, C., Dewitz, J., Jin, S., Xian, G., Costello, C., Danielson, P., Gass, L., Funk, M., Wickham, J., Stehman, S., Auch, R., & Riitters, K. Conterminous United States land cover change patterns 2001–2016 from the 2016 National Land Cover Database. ISPRS Journal of Photogrammetry and Remote Sensing, 162, 184–199.  (2020).

Multi-Resolution Land Characteristics (MRLC) Consortium (2025).  National Land Cover Database. https://www.mrlc.gov/

United States Department of Agriculture Crop Data Layer (2025). https://www.nass.usda.gov/Research_and_Science/Cropland/SARS1a.php

U.S. Geological Survey (USGS). 2022. Gap Analysis Project (GAP), Protected Areas Database of the United States (PAD-US) 3.0: U.S. Geological Survey data release. https://doi.org/10.5066/P96WBCHS.

United States Department of Agriculture Forest Service (2025.  LANDFIRE dataset. https://landfire.gov/version_download.php

United States Department of Agriculture Forest Service (2025). USDA Forest Service Grazing Dataset. https://data.fs.usda.gov/geodata/edw/datasets.php?xmlKeyword=grazing.

Falcone, J. (2016). Mapping enhanced grazing potential based on the NAWQA Wall-to-wall Anthropogenic Land-use Trends (NWALT) product. US Geological Survey. DOI	10.5066/F7CR5RFF. https://www.usgs.gov/data/mapping-enhanced-grazing-potential-based-nawqa-wall-wall-anthropogenic-land-use-trends-nwalt


### Output data
Oliver, J., & McManamay, R. (2024). United States Multi-Sector Dynamics land use and land cover base maps to support Human-Earth System Modeling (Version v1) [Data set]. MSD-LIVE Data Repository. https://doi.org/10.57931/2246609


## Contributing modeling software
| Model | Version | Repository Link | DOI |
|-------|---------|-----------------|-----|
| model 1 | version | link to code repository | link to DOI dataset |
| model 2 | version | link to code repository | link to DOI dataset |
| component 1 | version | link to code repository | link to DOI dataset |

## Reproduce my experiment



1. Install the software components required to conduct the experiment from [contributing modeling software](#contributing-modeling-software)
2. Download and install the supporting [input data](#input-data) required to conduct the experiment
3. Run the following scripts in the `workflow` directory to re-create this experiment:

| Script Name | Description | How to Run |
| --- | --- | --- |
| `step_one.py` | Script to run the first part of my experiment | `python3 step_one.py -f /path/to/inputdata/file_one.csv` |
| `step_two.py` | Script to run the second part of my experiment | `python3 step_two.py -o /path/to/my/outputdir` |

4. Download and unzip the [output data](#output-data) from my experiment 
5. Run the following scripts in the `workflow` directory to compare my outputs to those from the publication

| Script Name | Description | How to Run |
| --- | --- | --- |
| `compare.py` | Script to compare my outputs to the original | `python3 compare.py --orig /path/to/original/data.csv --new /path/to/new/data.csv` |

## Reproduce my figures
Use the scripts found in the `figures` directory to reproduce the figures used in this publication.

| Figure Number(s) | Script Name | Description | How to Run |
| --- | --- | --- | --- |
| 1, 2 | `generate_plot.py` | Description of figure, ie. "Plots the difference between our two scenarios" | `python3 generate_plot.py -input /path/to/inputs -output /path/to/outuptdir` |
| 3 | `generate_figure.py` | Description of figure, ie. "Shows how the mean and peak differences are calculated" | `python3 generate_figure.py -input /path/to/inputs -output /path/to/outuptdir` |

