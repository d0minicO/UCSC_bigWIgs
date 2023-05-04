## script to clean up DDX21 ChIP-seq bedgraph to limit text file only to specific predefined regions (genes of interest)

library(data.table)
library(tidyverse)
library(magrittr)

# source custom functions
devtools::source_url("https://github.com/d0minicO/phosphoR/blob/main/customFunctions.R?raw=TRUE")


# set the base directory
base = "C:/Users/dowens/OneDrive/Postdoc/Projects/GID4/Paper/Bioinformatics/DDX21_ChIP-seq/"




## define regions to keep

regs = c("chr10:70000000-71000000",
         "chr11:75000000-76000000",
         "chr8:146000000-147000000")


## read the file
list.files(base, pattern = ".bed")
dat = fread(paste0(base,"DDX21.bedGraph"))



# keep the good cols
dat %<>%
  dplyr::select(1:4)

# rename them
colnames(dat) = c("chr","start","stop","counts")


## filter on the regionschromosome
out.df = data.table()
for(r in regs){
  
  
  temp = makeChar(str_split(r,":"))
  
  ch=temp[1]
  sta = makeChar(str_split(temp[2],"-"))[1]
  stp = makeChar(str_split(temp[2],"-"))[2]
  
  temp =
    dat %>%
    filter(chr==ch) %>%
    filter(as.numeric(start)>sta & as.numeric(stop)<stp)
  
  out.df = rbind(out.df,temp)
  
  
}

out.df %<>% data.table()



## get the header back
con <- file(paste0(base,"DDX21.bedGraph"),"r")
first_line <- readLines(con,n=1)
close(con)

# put it back on the table
colnames(out.df)=c(first_line," "," "," ")

#save the new file
write.table(out.df,
            paste0(base,"DDX21.trim.bedGraph"),
            quote=F,
            col.names = T,
            row.names = F,
            sep="\t")