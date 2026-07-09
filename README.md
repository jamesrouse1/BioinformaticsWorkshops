<div align="center">

# Bioinformatics Teaching Materials

Workshop decks, notebooks, scripts, and practice materials for computational biology, genomics, statistics, R, Python, and machine learning.

Click a topic below to open the PDF preview directly in GitHub.

</div>

---

## Workshop Library

<table>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="python/slides/HandsOnWithPython_Workshop_Pt1.pdf">Python Workshop</a></h3>
      <p>Introductory Python for scientific computing, notebooks, practice questions, and solutions.</p>
      <p>
        <a href="python/slides/HandsOnWithPython_Workshop_Pt1.pdf">Open PDF</a> |
        <a href="python/notebooks/Python_Core_Series.ipynb">Notebook</a> |
        <a href="python/notebooks/Python_Core_Series_Practice.ipynb">Practice</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="r/slides/HandsOnWithR_Workshop_Pt1_Feb2026.pdf">R Workshop</a></h3>
      <p>Hands-on R workshop covering tabular data, plotting, count matrices, CPM, and reproducible scripts.</p>
      <p>
        <a href="r/slides/HandsOnWithR_Workshop_Pt1_Feb2026.pdf">Open PDF</a> |
        <a href="r/scripts/R_workshop_script.R">Script</a> |
        <a href="r/data/Tumor_vs_Normal_counts.csv">Example data</a>
      </p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="machine_learning/slides/BSR_James_ML_Workshop.pdf">Machine Learning Workshop</a></h3>
      <p>Decision trees, random forests, SVMs, hierarchical clustering, model practice, and introductory ML concepts.</p>
      <p>
        <a href="machine_learning/slides/BSR_James_ML_Workshop.pdf">Open PDF</a> |
        <a href="machine_learning/slides/Intro_MachineLearningInBioinformatics_RadUtama.pdf">Rad Utama intro PDF</a> |
        <a href="machine_learning/notebooks/model_practice_california_housing.ipynb">Practice notebook</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="scrna/slides/seurat_tutorial.pdf">Single-cell RNA-seq Workshop</a></h3>
      <p>Seurat tutorial materials for QC, clustering, annotation, marker discovery, and interpretation.</p>
      <p>
        <a href="scrna/slides/seurat_tutorial.pdf">Open PDF</a> |
        <a href="scrna/tutorial/seurat_tutorial.html">Rendered tutorial</a> |
        <a href="scrna/exercises/seurat_practice_questions.Rmd">Practice</a>
      </p>
    </td>
  </tr>
</table>

## Genomics Best Practices

<table>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/experimental_design.pdf">Experimental Design</a></h3>
      <p>Sample planning and design considerations for sequencing experiments.</p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/Biostats.pdf">Biostatistics</a></h3>
      <p>Power, statistical test selection, common assumptions, and practical interpretation.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/RNA_Seq_Best_Practices.pdf">RNA-seq Best Practices</a></h3>
      <p>Design, alignment, quantification, differential expression, and downstream interpretation.</p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/scRNA_best_practices.pdf">Single-cell RNA-seq Best Practices</a></h3>
      <p>QC, normalization, integration, clustering, and annotation concepts.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/ATACSeq_best_practices.pdf">ATAC-seq Best Practices</a></h3>
      <p>Library quality, alignment, accessibility, QC, and interpretation.</p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/ChIP_best_practices.pdf">ChIP-seq Best Practices</a></h3>
      <p>Controls, peak calling, signal tracks, QC, and experimental considerations.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/WGS_WES_best_practices.pdf">WGS/WES Best Practices</a></h3>
      <p>Reference-aware data handling, variant analysis concepts, and reproducible summaries.</p>
    </td>
    <td width="50%" valign="top">
      <h3><a href="genomics_best_practices/slides/long_read_best_practices.pdf">Long-read Sequencing Best Practices</a></h3>
      <p>Platform considerations, QC, alignment, and interpretation for long-read assays.</p>
    </td>
  </tr>
</table>

## Repository Layout

```text
.
├── genomics_best_practices/
│   └── slides/
├── machine_learning/
│   ├── notebooks/
│   └── slides/
├── python/
│   ├── notebooks/
│   └── slides/
├── r/
│   ├── data/
│   ├── scripts/
│   └── slides/
└── scrna/
    ├── exercises/
    ├── slides/
    └── tutorial/
```

## Suggested Use

- Start with the linked PDF for the topic.
- Use notebooks or scripts as live-coding material.
- Use practice notebooks and small example datasets for hands-on exercises.
- Use editable `.pptx` files only when preparing future workshop versions.

## Notes

These materials are intended for teaching, onboarding, and workshop use. Some examples are simplified intentionally so learners can focus on the core computational ideas before moving to full production workflows.
