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
