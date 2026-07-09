<div align="center">

<img src="assets/affiliation_logos.png" width="760" alt="Northeastern University, Incendia Therapeutics, and Cold Spring Harbor Laboratory"/>

# Bioinformatics Teaching Materials

Workshops, slides, notebooks, and reusable teaching scripts for computational biology, genomics, statistics, R, Python, and machine learning.

Workshop PDFs are the primary GitHub preview files. Editable PowerPoint decks are retained only where they are useful as source material for teaching updates. Genomics best-practices materials are kept as minimal CSHL-branded PDFs that preserve original charts, diagrams, and figures.

</div>

---

## Contents

| Topic | Materials |
| --- | --- |
| Python | Introductory Python workshop slides, notebooks, practice notebook, and solutions |
| R | Hands-on R workshop slides, R scripts, CPM practice materials, and small example count matrices |
| Machine learning | Workshop slides and notebooks covering decision trees, random forests, SVMs, hierarchical clustering, and model practice |
| Single-cell RNA-seq | Seurat tutorial slides, rendered tutorial HTML, R Markdown source, practice questions, and solutions |
| Genomics best practices | CSHL-branded PDF decks for RNA-seq, ATAC-seq, ChIP-seq, WGS/WES, long-read sequencing, single-cell RNA-seq, biostatistics, and experimental design |

## Repository Layout

```text
.
├── assets/
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

- Start with the `.pdf` deck for the topic.
- Use the `.pptx` files only when you want to edit the source slides for a future workshop.
- Use the notebooks or scripts as live-coding material.
- Use the practice notebooks and small example datasets for hands-on exercises.
- Adapt the best-practices decks for project onboarding, consultation, or short-format training.

## Topics Covered

### Programming

- Python basics for scientific computing
- R basics for tabular data, plotting, and count-matrix handling
- Reproducible scripts and notebooks

### Genomics

- RNA-seq experimental design and analysis concepts
- ATAC-seq and ChIP-seq best practices
- WGS/WES analysis concepts
- Long-read sequencing considerations
- Single-cell RNA-seq analysis with Seurat, including QC, clustering, annotation, and interpretation

### Statistics And Machine Learning

- Biostatistics and study design
- CPM normalization and simple count-matrix exercises
- Decision trees and random forests
- Support vector machines
- Hierarchical clustering for expression data
- Train/test thinking and model interpretation

## Notes

These materials are intended for teaching, onboarding, and workshop use. Some examples are simplified intentionally so learners can focus on the core computational ideas before moving to full production workflows.
