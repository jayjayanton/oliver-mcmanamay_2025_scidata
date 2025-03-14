import os
import rasterio
import numpy as np
from rasterio.mask import mask

# Define input directories and file paths
input_directory = "C:/Users/jayja/Landcover Change/Crop Data Layers/Processed Layers"
output_directory = "C:/Users/jayja/Landcover Change/Crop Data Layers/Processed Layers/Rainfed_Irrigated"
os.makedirs(output_directory, exist_ok=True)

# List of available irrigated land rasters
years_available = [2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017]

# Define classification values for extraction
crop_classes = [
    "Corn",
    "Wheat",
    "Rice",
    "Root_Tuber",
    "Oil_Crop",
    "Sugar_Crop",
    "Other_Grain",
    "Fiber_Crop",
    "Fodder_Grass",
    "Fodder_Herb",
    "Biomass_Grass",
    "Misc_Crop",
    "Other_Arable_Land"
]

# Process each processed land raster
for processed_file in os.listdir(input_directory):
    if processed_file.endswith(".tif"):
        # Extract the year and crop type from the filename
        file_parts = processed_file.split("_")
        try:
            year = int(file_parts[-1].split(".")[0])  # Extract year from filename
            crop_type = "_".join(file_parts[:-1])  # Extract crop type
        except ValueError:
            print(f"Skipping {processed_file}, could not extract year or crop type.")
            continue
        
        # Ensure the crop type is valid
        if crop_type not in crop_classes:
            print(f"Skipping {processed_file}, unknown crop type: {crop_type}.")
            continue
        
        # Determine the appropriate irrigated land raster
        if year > max(years_available):
            irrigated_year = max(years_available)  # Use the latest available irrigated land
        elif year in years_available:
            irrigated_year = year  # Use the exact year match
        else:
            print(f"No matching irrigated raster for {processed_file}. Skipping.")
            continue
        
        irrigated_raster_path = os.path.join(input_directory, f"Irrigated_Land_{irrigated_year}.tif")
        input_raster_path = os.path.join(input_directory, processed_file)
        output_irrigated_path = os.path.join(output_directory, f"Irrigated_{crop_type}_{year}.tif")
        output_rainfed_path = os.path.join(output_directory, f"Rainfed_{crop_type}_{year}.tif")
        
        try:
            with rasterio.open(irrigated_raster_path) as irr_src, rasterio.open(input_raster_path) as proc_src:
                irrigated_data = irr_src.read(1)
                processed_data = proc_src.read(1)
                profile = proc_src.profile
                
                # Mask processed layer based on irrigated land classification
                rainfed_data = np.where(irrigated_data == 1, 0, processed_data).astype(np.uint8)
                
                # Save the Rainfed raster
                profile.update(dtype=rasterio.uint8, count=1)
                with rasterio.open(output_rainfed_path, "w", **profile) as dst:
                    dst.write(rainfed_data, 1)
                
                print(f"Processed Rainfed/Irrigated classification for {processed_file} using {irrigated_year} irrigated land.")
        except Exception as e:
            print(f"Error processing {processed_file}: {e}")

print("Processing completed.")
