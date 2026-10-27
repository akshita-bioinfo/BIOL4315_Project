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

dir.create(path = "outputs/filtered_files", showWarnings = TRUE)

#------IN BASH------#
# using filtlong
# conda activate filtlong_env
# filtlong --keep_percent 75 data/wickerhamomycesAnomalus.fastq > outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# filtlong --keep_percent 75 data/hanseniasporaUvarum.fastq > outputs/filtered_files/HU_filtlong_filtered_reads.fastq

dir.create(path = "outputs/sequali_filtered_files", showWarnings = TRUE)

#-------IN BASH-----#
# Run Sequali over filtered files
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/HU_filtlong_filtered_reads.fastq
