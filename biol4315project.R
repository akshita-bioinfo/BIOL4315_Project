# BIOL4315_Project

# install packages if req
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rqc")

# Load required packages
library(Rqc)
library(ggplot2)
library(fastqcr) 
library(QuasR)
library(ShortRead)
library(here)

# check if fastq files exist
files <- list.files("data",
                    pattern = "\\.fastq$",
                    full.names =TRUE
                    )
files

#-------IN BASH------#
# pip install nanoplot
# NanoPlot --fastq data/wickerhamomycesAnomalus.fastq --outdir outputs/WA_nanoplot_report
# NanoPlot --fastq data/hanseniasporaUvarum.fastq --outdir outputs/HU_nanoplot_report

#------IN BASH-------#
# using sequali
# conda activate sequali-env
# sequali --outdir outputs/WAsequali_reports/ data/wickerhamomycesAnomalus.fastq
# sequali --outdir outputs/HUsequali_reports/ data/hanseniasporaUvarum.fastq

