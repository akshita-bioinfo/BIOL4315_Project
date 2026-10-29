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

#----------IN BASH: FILTLONG------#
# using filtlong
# conda activate filtlong_env
# filtlong --keep_percent 75 data/wickerhamomycesAnomalus.fastq > outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# filtlong --keep_percent 75 data/hanseniasporaUvarum.fastq > outputs/filtered_files/HU_filtlong_filtered_reads.fastq

dir.create(path = "outputs/sequali_filtered_files", showWarnings = TRUE)

#---------IN BASH: SEQUALI on FILTERED FILES------#
# Run Sequali over filtered files
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/WA_filtlong_filtered_reads.fastq
# sequali --outdir outputs/sequali_filtered_files/ outputs/filtered_files/HU_filtlong_filtered_reads.fastq
                                                       
dir.create(path = "outputs/assembly" , showWarnings = TRUE)

#-------------IN BASH: ASSEMBLY-----------------#
# flye --nano-raw outputs/filtered_files/WA_filtlong_filtered_reads.fastq --out-dir outputs/assembly/WA_flye_output --threads 8 --genome-size 12m
# flye --nano-raw outputs/filtered_files/HU_filtlong_filtered_reads.fastq --out-dir outputs/assembly/HU_flye_output --threads 8 --genome-size 12m

#----------IN BASH: MEDAKA POLISHING------------#
# MAKING REQUIRED DIRECTORIES
# mkdir -p outputs/medaka_round1 outputs/medaka_round2
# mkdir -p outputs/medaka_round1/WA outputs/medaka_round1/HU outputs/medaka_round2/WA outputs/medaka_round2/HU

# MEDAKA ROUND1 AND ROUND2 FOR WA
# medaka_consensus -i data/wickerhamomycesAnomalus.fastq -d outputs/assembly/WA_flye_output/assembly.fasta -o outputs/medaka_round1/WA -t 8
# medaka_consensus -i data/wickerhamomycesAnomalus.fastq -d outputs/medaka_round1/WA/consensus.fasta -o outputs/medaka_round2/WA -t 8

# MEDAKA ROUND1 AND ROUND2 FOR HU
# medaka_consensus -i data/hanseniasporaUvarum.fastq -d outputs/assembly/HU_flye_output/assembly.fasta -o outputs/medaka_round1/HU -t 8
# medaka_consensus -i data/hanseniasporaUvarum.fastq -d outputs/medaka_round1/HU/consensus.fasta -o outputs/medaka_round2/HU -t 8

#---------IN BASH: ASSEMBLY ANALYSIS------------#
# MAKING REQUIRED DIRECTORIES
# mkdir -p outputs/busco_output/WA
# docker run --rm \
# -v "$PWD":/data \
# -w /data \
# ezlabgva/busco:v6.0.0_cv1 \
# busco -i outputs/medaka_round2/WA/consensus.fasta -o outputs/busco_output/WA -l saccharomycetaceae_odb12 -m genome -c 8

