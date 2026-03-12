# RNA-seq Analysis of TYK2 Knockout During Pancreatic Endocrine Differentiation

## Project Overview

This project implements a reproducible RNA-seq analysis pipeline to investigate
transcriptional changes associated with TYK2 knockout during pancreatic
endocrine differentiation.

The analysis reproduces key transcriptomic findings from Chandra et al. (2022),
which examined how disruption of the TYK2 gene alters gene expression during
the endocrine progenitor stage of pancreatic development.

#### *Biological Context of Study*
Type 1 diabetes results from immune-mediated destruction of
insulin-producing pancreatic β-cells.

The TYK2 gene is part of the JAK/STAT signaling pathway and has been
implicated as a genetic risk factor for Type 1 diabetes.

The referenced study investigated how TYK2 knockout affects transcriptional
programs during pancreatic endocrine differentiation using RNA-seq.

## Project Goals 

This project aimed to reproduce the transcriptomic analyses from the study,
focusing on Stage 5 pancreatic endocrine progenitor cells.

Specifically, the analysis reproduces:

• Differential gene expression between TYK2 knockout and wild-type samples  
• Pathway enrichment analysis of significant genes  
• Visualization of transcriptional changes (volcano plots, PCA, heatmaps)  
• Enrichment analysis of biological pathways affected by TYK2 loss

## Computational Pipeline Overview

This RNA-seq workflow consists of the following stages:

1. Quality control of raw RNA-seq reads using FastQC
2. Alignment of reads to the reference genome using STAR
3. Gene-level quantification using VERSE
4. A Python processing script to combine VERSE-generated count files into a single expression matrix
5. Differential expression analysis using DESeq2 in R
6. Pathway enrichment analysis using Enrichr and FGSEA
7. Visualization of results (PCA, volcano plots, heatmaps)

## Programs & Tools

**Workflow**: Nextflow

**Quality control**: FastQC, MultiQC

**Alignment**: STAR (splice-aware aligner)

**Quantification**: VERSE

**Statistical analysis**: DESeq2 (R)

**Pathway enrichment**: Enrichr, FGSEA, MSigDB pathway databases

## Repository Structure

```
rna-seq-analysis/
│
├── envs/           # conda environments for reproducibility
├── figures/        # plots generated from analysis
├── modules/        # Nextflow processes for each tool
│
├── coldata.csv.    # Sample metadata mapping samples to experimental conditions (control vs. TYK2 KO)
├── gene_names.txt
├── deseq2_sig_genes.txt
├── fgsea_pathways.txt
│
├── main.nf         # Nextflow main workflow pipeline
├── nextflow.config # Reference and param files 
│
├── verse_argparse.py
├── rna-seq-tyk2.R
├── README.md
```

## Key Results of Study

Differential expression analysis identified over 1,200 genes significantly altered between TYK2 knockout and control samples. Several key transcription factors required for pancreatic endocrine differentiation, including **NEUROG3, NKX2-2, and INSM1**, were downregulated in the knockout condition, suggesting impaired β-cell developmental programming. In contrast, genes associated with receptor tyrosine kinase signaling and extracellular matrix organization were upregulated, indicating increased proliferative signaling. Pathway enrichment analysis further supported these trends, highlighting disruptions in cell differentiation, neuronal signaling pathways, and stress response networks. Together, these results reproduce the main findings of the original study, demonstrating that loss of TYK2 alters transcriptional programs required for proper endocrine pancreas development.

## Skills Demonstrated

• RNA-seq data analysis & reproducible workflow

• Nextflow pipeline development

• Differential gene expression analysis

• Functional enrichment analysis

• Biological interpretation of transcriptomic data

#### Citation

Chandra et al. (2022)
The type 1 diabetes gene TYK2 regulates β-cell development and its
responses to interferon-α.
Nature Communications