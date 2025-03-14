import os
import rasterio
import numpy as np
from rasterio.merge import merge

# Define input directories and file paths
input_directory = "./Landcover Change/Crop Data Layers/Reclassified"
output_directory = "./Landcover Change/Crop Data Layers/CDL Crop Mask"
os.makedirs(output_directory, exist_ok=True)

# Define classification values for extraction
crop_classes = {
    "Corn": [2, 11, 12],
    "Wheat": [15, 16, 17, 32],
    "Rice": [4],
    "Root_Tuber": [35, 38, 129],
    "Oil_Crop": [6, 7, 24, 26, 27, 28, 98, 94],
    "Sugar_Crop": [33, 37],
    "Other_Grain": [14, 18, 20, 21, 22, 23, 88],
    "Fiber_Crop": [3],
    "Fodder_Grass": [30],
    "Fodder_Herb": [5, 29, 50, 107],
    "Biomass_Grass": [31, 52],
    "Misc_Crop": [9, 10, 13, 19, 25, 34, 36, 39, 40],
    "Other_Arable_Land": [53]
}

# Process each raster file in the input directory
for year in [2008, 2011, 2013, 2016]:
    raster_files = [f for f in os.listdir(input_directory) if f.endswith(f"_{year}.tif")]
    crop_rasters = []
    crop_profiles = None
    
    for raster_file in raster_files:
        input_raster_path = os.path.join(input_directory, raster_file)
        
        with rasterio.open(input_raster_path) as src:
            raster_data = src.read(1)
            profile = src.profile
            
            for crop, values in crop_classes.items():
                output_crop_path = os.path.join(output_directory, f"Extract_CDL_{crop}_{year}.tif")
                crop_mask = np.isin(raster_data, values).astype(np.uint8)
                
                # Save each crop classification raster
                profile.update(dtype=rasterio.uint8, count=1)
                with rasterio.open(output_crop_path, "w", **profile) as dst:
                    dst.write(crop_mask, 1)
                
                crop_rasters.append((crop_mask, src.transform))
                crop_profiles = profile  # Store profile for final merged raster
    
    if crop_rasters:
        # Merge all extracted rasters
        merged_array, merged_transform = merge([r[0] for r in crop_rasters])
        output_raster_path = os.path.join(output_directory, f"CDL_Crop_Mask_{year}.tif")
        
        # Save the merged raster
        crop_profiles.update(dtype=rasterio.uint8, count=1, transform=merged_transform)
        with rasterio.open(output_raster_path, "w", **crop_profiles) as dst:
            dst.write(merged_array[0], 1)
        
        print(f"Merged raster for {year} saved as {output_raster_path}")

print("Processing completed.")
