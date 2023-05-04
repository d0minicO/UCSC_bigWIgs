## script for converting bigwig to bedgraph

library(tidyverse)
library(magrittr)


#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install(version = "3.15")

## great package for loading bigwigs
#BiocManager::install("rtracklayer")
library(rtracklayer)



################
#### inputs ####
################

base = "C:/Users/dowens/OneDrive/Postdoc/Projects/NSD2/CUT&RUN/bigWigs/merged/"

## chr to filter on
chr="chr18"

## read the files
files = list.files(base, pattern = ".bw")

## output directory
out.dir = paste0(base,"bdg/")
dir.create(out.dir)

for(f in files){
  
  
  file = paste0(base,f)
  
  
  ####################
  #### Processing ####
  ####################
  
  ## read the bigwig file
  bw = rtracklayer::import(file)
  
  outfile = paste0(out.dir,f,".bedGraph")
  
  bw %<>%
    data.frame %>%
    dplyr::select(1,2,3,6)
  
  ## filter on desired chr
  bw %<>%
    filter(seqnames==!!chr)
  
  # save a header then the bedgraph file
  cat(paste0("track type=bedGraph name=",f,"\n"),file=outfile)
  write.table(bw,
              file=outfile,
              col.names =F,
              row.names = F,
              quote = F,
              sep="\t",
              append = T)
  
}



