import glob
import os
import rasterio
import pandas as pd
import numpy as np
from rasterio.features import geometry_mask
from rasterio import features

# Define workspace and folders
workspace = r".\CLM\Tabulated Data" # Where Tabulated data will be saved for CLM 
# workspace = r".\LUH2\Tabulated Data" # Where Tabulated data will be saved for LUH2
os.makedirs(workspace, exist_ok=True)
excel_folder = r".\CLM\Excel Files" # Your CLM directory for Excel Files
# excel_folder = r".\KLUH2\Excel Files" # Your LUH2 directory for Excel Files
os.makedirs(excel_folder, exist_ok=True)
proportion_tables = r".\CLM\Weighted Proportion" # Weighted proportion for CLM
# proportion_tables = r".\LUH2\Weighted Proportion" # Weighted proportion for LUH2
os.makedirs(proportion_tables, exist_ok=True)

# Get list of TIFF files for CLM PFTs and LUH2 States
tiff_files = sorted(glob.glob("*.tif"))

# Define input layer and parameters
inlayer = r".\MSD_Map\Landcover_2008.tif" # File found in MSD Live
zone_field = "Value"
class_field = "Value"
processing_cell_size = 30

# Function to perform tabulate area using rasterio
def tabulate_area(input_raster, inlayer):
    with rasterio.open(input_raster) as src:
        raster_array = src.read(1)
        transform = src.transform

    with rasterio.open(inlayer) as base:
        base_array = base.read(1)
        base_transform = base.transform

    results = []
    for val in set(base_array.flatten()):
        if val == 0:  # Assuming 0 is NoData
            continue
        mask = base_array == val
        masked_data = raster_array[mask]
        unique, counts = np.unique(masked_data, return_counts=True)
        for u, c in zip(unique, counts):
            results.append({zone_field: val, class_field: u, "Area": c * (processing_cell_size ** 2)})

    return pd.DataFrame(results)

# Process each TIFF file
for tiff in tiff_files:
    base_filename = os.path.basename(tiff)
    clean_base_str = os.path.splitext(base_filename)[0]
    outfile_name = f"{clean_base_str}.csv"
    
    # Compute tabulated area
    df = tabulate_area(tiff, inlayer)
    df.to_csv(os.path.join(workspace, outfile_name), index=False)
    print(f"Done: {clean_base_str}")

# Convert CSV files to Excel
# Convert CSV files to Excel
csv_files = sorted(glob.glob(os.path.join(workspace, "*.csv")))

for name in csv_files:
    base_filename = os.path.basename(name)
    clean_base_str = os.path.splitext(base_filename)[0]
    value = clean_base_str.split('_')[-1]  # Adjusting split logic
    out_xls = f"PFT_{value}.xlsx" # CLM Files
    # out_xls = f"States_{value}.xlsx" LUH2 Files
    output_file = os.path.join(excel_folder, out_xls)
    
    df = pd.read_csv(name)
    df.to_excel(output_file, index=False)
    print(f"Excel created: {output_file}")

# Process Weighted Tabulation
final_tabulated_values = sorted(glob.glob(os.path.join(excel_folder, "*.xlsx")))
all_dfs = []

for name in final_tabulated_values:
    base_filename = os.path.basename(name)
    clean_base_str = os.path.splitext(base_filename)[0]
    value = clean_base_str.split('_', -1)[1]
    df = pd.read_excel(name)
    
    # Calculate proportion of GCAM basemap within tabulated area
    df.iloc[:, 6:] = df.iloc[:, 6:].div(df["TABULATED AREA"], axis=0)
    df.iloc[:, 6:] = df.iloc[:, 6:].mul(df['VALUE'], axis=0)
    
    # Sum all Pixel Values
    df.loc[df.index[-1], 'VALUE'] = df['VALUE'].sum()
    df.iloc[-1, 6:] = df.iloc[:, 6:].sum()
    df.iloc[-1, 6:] = df.iloc[-1, 6:].div(df.loc[df.index[-1], 'VALUE'])
    
    # Save to Excel
    out_xls = f"PFT_{value}_Weighted_Tabulated_Proportion.xlsx"
    # out_xls = f"States_{value}_Weighted_Tabulated_Proportion.xlsx" #LUH2 Proportions
    output_file = os.path.join(proportion_tables, out_xls)
    df.to_excel(output_file, index=False)
    print(f"Processed: {output_file}")
    all_dfs.append(df)

# Merge all dataframes into one
merged_df = pd.concat(all_dfs, ignore_index=True)
out_csv = os.path.join(proportion_tables, "PFT_Appended_Wt_Prop.csv")
# out_csv = os.path.join(proportion_tables, "LUH2_Appended_Wt_Prop.csv")
merged_df.to_csv(out_csv, index=False)
print(f"Merged CSV created: {out_csv}")
