# ---------------------------------------------------------------------------------
# Coursera.org - Data Science Specialization - Capstone Project
# 
# >> functions to get statistics for Capstone Dataset files - size, lines and words
# author..: Sergio Vicente (@svicente99)
# data....: 20th Dec. 2015
# ---------------------------------------------------------------------------------

# this package remove url addresses and some twitter features such as retweets, @people, # (hash tags) and emoticons
if(!require("qdapRegex")) {
    install.packages("qdapRegex")
}
library(qdapRegex)

removeTweetFeatures <- function(str) 
{ 
  # erase url addresses
  str <- gsub("http\\w+", "", str)

  # erase @people names
  str <- gsub("@\\w+", "", str)

  # erase retweets 
  str <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", str)

  # erase hash tags, emoticons and urls using package 'qdapRegex'
  str <- rm_hash(str)
  str <- rm_emoticon(str)
  str <- rm_url(str)
}

removeOtherFeatures <- function(corp, numbers=TRUE, punctuation=TRUE, spaces=TRUE, stopwords=TRUE) {
  if(numbers)  	   corp <- tm_map(corp, removeNumbers)
  if(punctuation)  corp <- tm_map(corp, removePunctuation)
  if(spaces)	   corp <- tm_map(corp, stripWhitespace)
  if(stopwords)    corp <- tm_map(corp, removeWords, stopwords("english"))

  # the list of 'stopwords' could be confirmed in next link, according to "quanteda.pdf" package documentation
  # http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop
  # http://stackoverflow.com/questions/7927367/r-text-file-and-text-mining-how-to-load-data

  return(corp)
}
