# ---------------------------------------------------------------------
# Coursera.org - Data Science Specialization - Capstone Project
# 
# >> Explore dataset files (samples)
# author..: Sergio Vicente (@svicente99)
# data....: 26th Dec. 2015
# ---------------------------------------------------------------------

DATASET_DIR = "./Capstone_Dataset/"
SAMPLE_DIR  = "./Samples/"

SAMPLE_CORPUS = "sample_corpus.txt"
SAMPLE_CLEAN  = "sample_clean.txt"

cFiles <- c("news","twitter","blogs")

library(tm)
library(quanteda);
# http://pnulty.github.io/

objRDS <- function(f) {
  return( readRDS(paste0(f, ".rds")) )
}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

startTime <- Sys.time()

# generate a txt file with corpora sampling from "Swift Key Dataset", in case of not exists

if(!file.exists(paste0(SAMPLE_DIR,SAMPLE_CORPUS))) 
  lapply(cFiles, 
    function(i) {
      write.table(objRDS(i), paste0(SAMPLE_DIR,SAMPLE_CORPUS), sep="\t", col.names=FALSE, quote=FALSE, row.names=FALSE, append=TRUE) }
  )

# create a primary Corpus using "tm" package that contains all sample texts (as Source) to be cleaned
# (because cleaning functions for "quanteda' package aren't working fine...)

# generate a clean txt file with corpora sampling , in case of not exists

if(!file.exists(SAMPLE_CLEAN)) 
{
  cp <- Corpus(DirSource(SAMPLE_DIR), readerControl = list(language="lat"))
  cp <- tm_map( tm_map(cp, removeNumbers), removePunctuation )
  cp <- tm_map(cp, removeWords, stopwords("english"))

  # the list of 'stopwords' could be confirmed in next link, according to "quanteda.pdf" package documentation
  # http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop
  # http://stackoverflow.com/questions/7927367/r-text-file-and-text-mining-how-to-load-data

  # and now, rewrite these data to another file representing sample Corpora already clean up
  dfClean <- data.frame(text=unlist(sapply(cp, `[`, "content")), stringsAsFactors=F) 
  write.table(dfClean, SAMPLE_CLEAN, sep="\t", col.names=FALSE, quote=FALSE, row.names=FALSE, append=TRUE)
  rm(cp)	# (release memory)
}

# this 'sample clean text file' could be a source to "corpus" method in "quanteda" package
mycorp <- corpus(textfile(SAMPLE_CLEAN))

# summarizing my corpora
summary(mycorp)

# tokenize the texts from the corpora (one-gram, 2-grams, 3-grams) in data frames in order to
# show its frequency distribution

for(i in 1:3) {
  tk <- tokenize(mycorp, ngrams=i, concatenator=',')
  #colnames(dfg[1]) <- paste0(i,"-word")
  plot_bar_gram( table_tokens(tk), i)
}
rm(tk)


# create a dfm, removing stopwords and stemming (not lowering, because it's already done)
# https://github.com/kbenoit/quanteda/issues/50

mydfm <- dfm(mycorp, verbose = TRUE, toLower = FALSE, language="english", stem=TRUE, 
  removeNumbers = TRUE, removePunct = TRUE, removeSeparators = TRUE) 

# ignoredFeatures = stopwords('english'),

# basic dimensions of the dfm
print("Dimensions of dfm - Document-Frequency Matrix")
print(dim(mydfm))

# displaying 25 top words
print("25 top frequency words")
print(topfeatures(mydfm, 25))

stopTime <- Sys.time()

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

print(sprintf('Processing time: %6.2f minutes',  difftime(stopTime, startTime, units = "mins"))) 
     
