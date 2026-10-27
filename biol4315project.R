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

#-------IN BASH: NANOPLOT------#
# pip install nanoplot
# NanoPlot --fastq data/wickerhamomycesAnomalus.fastq --outdir outputs/WA_nanoplot_report
# NanoPlot --fastq data/hanseniasporaUvarum.fastq --outdir outputs/HU_nanoplot_report

#------IN BASH: SEQUALI-------#
# using sequali
# conda activate sequali-env
# sequali --outdir outputs/WAsequali_reports/ data/wickerhamomycesAnomalus.fastq
# sequali --outdir outputs/HUsequali_reports/ data/hanseniasporaUvarum.fastq

dir.create(path = "outputs/filtered_files", showWarnings = TRUE)

#------IN BASH: FILTLONG------#
# using filtlong
# conda activate filtlong_env
# filtlong --keep_percent 75 data/wickerhamomycesAnomalus.fastq > outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# filtlong --keep_percent 75 data/hanseniasporaUvarum.fastq > outputs/filtered_files/HU_filtlong_filtered_reads.fastq

dir.create(path = "outputs/sequali_filtered_files", showWarnings = TRUE)

#-------IN BASH: SEQUALI on FILTERED FILES-----#
# Run Sequali over filtered files
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/HU_filtlong_filtered_reads.fastq

dir.create(path = "outputs/assembly" , showWarnings = TRUE)

#-------IN BASH: ASSEMBLY------#
# flye --nano-raw outputs/filtered_files/WA_filtlong_filtered_reads.fastq --out-dir outputs/assembly/WA_flye_output --threads 8 --genome-size 12m
# flye --nano-raw outputs/filtered_files/HU_filtlong_filtered_reads.fastq --out-dir outputs/assembly/HU_flye_output --threads 8 --genome-size 12m