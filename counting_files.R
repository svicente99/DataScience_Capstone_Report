# ---------------------------------------------------------------------
# Coursera.org - Data Science Specialization - Capstone Project
# 
# >> Counting on dataset files
# author..: Sergio Vicente (@svicente99)
# data....: 22th Dec. 2015
# ---------------------------------------------------------------------

DATASET_DIR = "./Capstone_Dataset/"

cFiles = c("blogs", "news", "twitter")

sizeOf <- function(f) {
  nmFile = paste0("en_US/en_US.",f,".txt")
  arq <- paste(DATASET_DIR,nmFile,sep="")
  print(arq)
  file_size <- file.info(arq)$size / 1024 / 1024
  print(paste(sprintf("%5.1f",file_size),"Megabytes"))
}

linesOf <- function(f) {
  nmFile = paste0("en_US/en_US.",f,".txt")
  arq <- paste(DATASET_DIR,nmFile,sep="")
  print(arq)
  len <- length(readLines(arq))
  print(paste(format(len,big.mark=" ",decimal.mark="."),"lines of text"))  
}

lapply(cFiles, function(f) sizeOf(f))

lapply(cFiles, function(f) linesOf(f))
