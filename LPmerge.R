#!/usr/bin/Rscript

library("LPmerge")
args <- commandArgs(trailingOnly = TRUE)
map.names <- c(args[1], args[2])
Maps <- list()
i <- 1

for (i in 1:2) {
	filename <- paste(map.names[i], '.csv', sep='')
	input <- read.csv(filename, header=T, as.is=T, check.names=F, sep=",")
	#print(input)
	Maps [[i]] <- input[which(input$chr==args[3]), c(1,3)]
}
names(Maps) <- map.names
str(Maps)

unweighted <- LPmerge(Maps, max.interval= as.numeric(args[4]):as.numeric(args[5]))
