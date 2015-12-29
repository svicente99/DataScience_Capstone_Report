# ---------------------------------------------------------------------
# Coursera.org - Data Science Specialization - Capstone Project
# 
# >> Counting on dataset files
# author..: Sergio Vicente (@svicente99)
# data....: 22th Dec. 2015
# ---------------------------------------------------------------------

if(!require("tm")) {
    install.packages("tm")
}
library(tm)

DATASET_DIR = "./Capstone_Dataset/"

totSize <- 0
totLines <- 0

cFiles = c("blogs", "news", "twitter")

sizeOf <- function(f) {
  nmFile = paste0("en_US/en_US.",f,".txt")
  arq <- paste(DATASET_DIR,nmFile,sep="")
  print(arq)
  file_size <- file.info(arq)$size / 1024 / 1024
  print(paste(sprintf("%5.1f",file_size),"Megabytes"))
  
  totSize <<- totSize + file_size
}

linesOf <- function(f) {
  nmFile = paste0("en_US/en_US.",f,".txt")
  arq <- paste(DATASET_DIR,nmFile,sep="")
  print(arq)
  len <- length(readLines(arq))
  print(paste(format(len,big.mark=" ",decimal.mark="."),"lines of text"))  
  
  totLines <<- totLines + len
}

lapply(cFiles, function(f) sizeOf(f))

lapply(cFiles, function(f) linesOf(f))

print(paste("Total size is",sprintf("%5.1f",totSize,"Megabytes")))
print(paste("Total lines is",format(totLines,big.mark=" ",decimal.mark=".")))

#-- to count Words for 3 files for English LOCALE --#

word_count <- function() {
  corp <- Corpus(DirSource(paste0(DATASET_DIR,"en_US")))
  summary(corp)
  dtm<-DocumentTermMatrix(corp)
  print(dtm)

  remove(corp)
  remove(dtm)
}
