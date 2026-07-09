#!/usr/bin/env Rscript

# Reusable starter template for a Seurat-based single-cell RNA-seq workshop.
# Replace the input paths and metadata columns with values from the teaching dataset.

suppressPackageStartupMessages({
  library(Seurat)
  library(ggplot2)
})

project_name <- "scRNA_workshop"
counts_dir <- "path/to/filtered_feature_bc_matrix"
metadata_path <- "path/to/metadata.csv"
out_dir <- file.path("results", project_name)
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

obj <- Read10X(data.dir = counts_dir)
obj <- CreateSeuratObject(counts = obj, project = project_name, min.cells = 3, min.features = 200)

if (file.exists(metadata_path)) {
  metadata <- read.csv(metadata_path, row.names = 1, check.names = FALSE)
  obj <- AddMetaData(obj, metadata = metadata)
}

obj[["percent.mt"]] <- PercentageFeatureSet(obj, pattern = "^MT-|^mt-")

qc_plot <- VlnPlot(obj, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
ggsave(file.path(out_dir, "qc_violin.png"), qc_plot, width = 10, height = 4, dpi = 300)

obj <- subset(obj, subset = nFeature_RNA > 200 & nFeature_RNA < 6000 & percent.mt < 20)
obj <- NormalizeData(obj)
obj <- FindVariableFeatures(obj, selection.method = "vst", nfeatures = 2000)
obj <- ScaleData(obj)
obj <- RunPCA(obj)
obj <- FindNeighbors(obj, dims = 1:20)
obj <- FindClusters(obj, resolution = 0.5)
obj <- RunUMAP(obj, dims = 1:20)

umap_plot <- DimPlot(obj, reduction = "umap", label = TRUE) + NoLegend()
ggsave(file.path(out_dir, "umap_clusters.png"), umap_plot, width = 6, height = 5, dpi = 300)

markers <- FindAllMarkers(obj, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
write.csv(markers, file.path(out_dir, "cluster_markers.csv"), row.names = FALSE)

saveRDS(obj, file.path(out_dir, "seurat_object.rds"))
