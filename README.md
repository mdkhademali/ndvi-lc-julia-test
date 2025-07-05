## Simple Julia GIS Project: NDVI Calculation and Land Classification

This is a small GIS project written in Julia that performs NDVI calculation and simple land classification from satellite imagery. It uses synthetic data for demonstration purposes but can be adapted to real satellite images.

## Requirements

- Julia 1.6 or later
- Packages:
  - ArchGDAL
  - Plots

## Installation

Activate the project environment and install dependencies:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

If you don't have `Project.toml`, install packages manually:

```julia
Pkg.add("ArchGDAL")
Pkg.add("Plots")
```

## How to Run

1. Run the `main.jl` script in Julia:

```julia
include("main.jl")
```

2. The script will:

- Generate synthetic Red and NIR bands and save as `data/sample.tif`
- Calculate NDVI and display the NDVI heatmap
- Classify land using NDVI threshold (0.3) and display classification map
- Save classified raster to `output/classified_output.tif`

## Output

- `data/sample.tif`: Synthetic input satellite image with Red and NIR bands.
- `output/classified_output.tif`: Classified land raster (1 = vegetation, 0 = non-vegetation).

## Notes

- You can replace `data/sample.tif` with your own GeoTIFF containing Red and NIR bands.
- The classification threshold and visualization can be customized in `main.jl`.