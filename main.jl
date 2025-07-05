# main.jl
# Complete Julia GIS Mini Project with synthetic data

using ArchGDAL
using Plots

# Create synthetic raster bands (100x100)
width, height = 100, 100
red_band = rand(UInt8, height, width) .% 100 .+ 50     # Simulated Red
nir_band = rand(UInt8, height, width) .% 100 .+ 100    # Simulated NIR

# Save synthetic data as sample.tif with bands 3 and 4
mkpath("data")
ArchGDAL.create("data/sample.tif", driver = "GTiff",
    width = width, height = height, nbands = 4,
    dtype = ArchGDAL.GDT_Byte) do ds
    ArchGDAL.write!(ArchGDAL.getband(ds, 3), red_band)
    ArchGDAL.write!(ArchGDAL.getband(ds, 4), nir_band)
end

println("✅ Synthetic data created: data/sample.tif")

# Load raster
dataset = ArchGDAL.read("data/sample.tif")

# Read Red and NIR bands
red = ArchGDAL.read(ArchGDAL.getband(dataset, 3))
nir = ArchGDAL.read(ArchGDAL.getband(dataset, 4))

# NDVI calculation
ndvi = (nir .- red) ./ (nir .+ red .+ eps())

# NDVI map
heatmap(ndvi, color = :Greens, title = "NDVI Map", size = (600, 400), show = true)

# Classification: NDVI > 0.3
classified = map(x -> x > 0.3 ? 1 : 0, ndvi)

# Classified map
heatmap(classified, color = [:brown :green], title = "Land Classification", size = (600, 400), show = true)

# Save classified output
mkpath("output")
ArchGDAL.create("output/classified_output.tif", driver = "GTiff",
    width = size(classified, 2), height = size(classified, 1),
    nbands = 1, dtype = ArchGDAL.GDT_Byte) do out_ds
    ArchGDAL.write!(ArchGDAL.getband(out_ds, 1), classified)
end

println("✅ Done! NDVI and classification complete. Output saved in 'output/'")