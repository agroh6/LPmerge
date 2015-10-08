#!/usr/bin/Rscript

## Creates a list called "Map" of the markers and cM for one LG from 
## two different maps. Uses LPmerge to make a consensus map.
## args 1 and 2 muxt have the file extension included in the input.

library("LPmerge")
args <- commandArgs(trailingOnly = TRUE)
map.names <- c(args[1], args[2])
Maps <- list()
i <- 1

for (i in 1:2) {
	input <- read.csv(map.names[i], header=T, as.is=T, check.names=F, sep=",")
	#print(input)
	Maps [[i]] <- input[which(input$chr==args[3]), c(1,3)]
}
#names(Maps) <- map.names
#str(Maps)

unweighted <- LPmerge(Maps, max.interval= as.numeric(args[4]):as.numeric(args[5]))
