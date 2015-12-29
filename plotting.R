# ---------------------------------------------------------------------
# Coursera.org - Data Science Specialization - Capstone Project
# 
# >> Explore dataset files (graph plots)
# author..: Sergio Vicente (@svicente99)
# data....: 26th Dec. 2015
# ---------------------------------------------------------------------


# plot Horizontal Bar graphs for 25 first more frequency tokens: 1-gram, 2-grams, 3-grams

table_tokens <- function(tk, f=25) {
  tb <- table(data.frame(tk))
  tb_ord <- sort(tb)
  return( tail(tb_ord, f) )
}

plot_bar_gram <- function(tb, ng) {
  nmGraph <- paste0(ng,'-gram')
  png(paste0(nmGraph,".png"), width=3500, height=3500, res=400)
  par(mar=c(6, 11 , 4, 2))
  
  # http://stackoverflow.com/questions/8112786/how-to-split-the-main-title-of-a-plot-in-2-or-more-lines
  # las=1 : make label text horizontal to y-axis
  
  barplot(tb, main=paste("Distribution of Token Frequencies","\n",nmGraph), horiz=TRUE, ylab="", xlab="Frequency", las=1)
  # save graph
  print(paste0("Saving PNG graph: ",nmGraph,".png"))
  dev.off()
}

# -------------------------------------------------------------------------------------------------------

# plot a word cloud - an handy tool to highlight the most frequent words found in these Corpora
# Ref.: http://onertipaday.blogspot.com.br/2011/07/word-cloud-in-r.html

if(!require("wordcloud")) {
    install.packages("wordcloud")
}
if(!require("RColorBrewer")) {
    install.packages("RColorBrewer")
}

library(wordcloud)
library(RColorBrewer)

plot_word_cloud <- function(corp) {
  tdm <- TermDocumentMatrix(corp)
  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  pal <- brewer.pal(9, "BuGn")
  pal <- pal[-(1:2)]
  png("wordcloud.png", width=1280,height=800)
  wordcloud(d$word,d$freq, scale=c(8,.3),min.freq=2,max.words=100, random.order=T, rot.per=.15, colors=pal, vfont=c("sans serif","plain"))
  dev.off()
}
