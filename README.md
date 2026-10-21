# Functional Characterisation of Dairy Slurry Metagenomes

**Undergraduate research project | University of Nottingham | 2026**

Analysis of temporal changes in predicted microbial functions in dairy slurry during seven weeks of storage, using Gene Ontology (GO) and KEGG pathway annotations.

## Research question
How do microbial functional profiles change during slurry storage, and what might these changes suggest about adaptation and antimicrobial resistance (AMR)-associated functions?

## Dataset
Publicly available metagenomic reads from Baker et al. (2022), ENA project **PRJEB38990**. This analysis focused on two untreated control mini-tanks at four timepoints (T0, T2, T4, T7), totalling eight samples.

## Workflow
1. Quality assessment of paired-end sequencing reads with **FastQC**.
2. Adapter/quality trimming with **fastp**.
3. Per-sample assembly using **MEGAHIT** through **Galaxy Europe**.
4. Coding-sequence prediction using **Prodigal**.
5. Functional annotation using **eggNOG-mapper** through **Galaxy Europe**.
6. Extraction, filtering and relative-abundance normalisation of **GO** and **KEGG** annotations using Linux command-line tools.
7. Analysis and visualisation in **R**, including **ggplot2** and **pheatmap**.

## Key findings
- KEGG-based hierarchical clustering grouped samples predominantly by storage timepoint rather than tank identity, particularly at weeks 2 and 4.
- Early-stage samples showed greater representation of growth- and biosynthesis-related pathways; later samples were relatively enriched in environmental sensing and adaptation-related pathways.
- The two tanks diverged more strongly by week 7.
- Selected beta-lactam and vancomycin resistance pathway indicators declined modestly, whereas the CAMP resistance indicator increased late in storage. These annotations do **not** directly establish resistance phenotypes.

## Repository contents
- `scripts/shell/`: example preprocessing and annotation-table processing commands.
- `scripts/R/`: analysis and plotting code extracted from the dissertation appendix.
- `figures/`: selected figures from the dissertation for quick review.

## Reproducibility and limitations
These scripts are **archival examples extracted from the dissertation appendix**, not a fully tested, turnkey pipeline. Some scripts reference intermediate files not included here; some visualisations contain values transcribed into R code. MEGAHIT and eggNOG-mapper steps were run through Galaxy Europe. The original data are large and are not redistributed here. The source transcript should be reviewed and code paths checked before rerunning. The analysis includes only two biological replicate tanks and measures inferred functional potential, not gene expression.

## Attribution
Original sequencing data: Baker et al. (2022), *Antimicrobial resistance in dairy slurry tanks: A critical point for measurement and control*, Environment International 169, 107516. https://doi.org/10.1016/j.envint.2022.107516

Research project conducted at the University of Nottingham. The dissertation reports use of ChatGPT and Claude to assist with selected coding, troubleshooting and figure-generation tasks.

## Before publishing
Confirm university/supervisor permission to share the work and check any institutional IP policies. Review extracted scripts, labels, file paths, and figures before making the repository public.
