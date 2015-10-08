#!/usr/bin/Rscript

## Creates a list called "Map" of the markers and cM for one LG from 
## two different maps. Uses LPmerge to make a consensus map.
## args 1 and 2 muxt have the file extension included in the input.
## Weighs each input map based on number of markers in the LG.
## Allows you to make consensus maps for all LG at once (not one at a time).

library("LPmerge")
args <- commandArgs(trailingOnly = TRUE)  ## Allows you to add args in terminal
map.names <- c(args[1], args[2])          ## Names of map files to combine
LGs <- c("1LG", "2LG", "3LG", "4LG", "5LG", "6LG", "7LG", "8LG", "9LG", 
	"10LG", "11LG", "12LG", "13LG", "14LG", "15LG", "16LG", "17LG", "18LG",
	"19LG", "20LG")
Maps <- list()
i <- 1

for (n in 1:20) {

# for loop makes a list of markers and cMs for one LG to use in LPmerge function
	for (i in 1:2) {
		input <- read.csv(map.names[i], header=T, as.is=T, check.names=F, sep=",")
		#print(input)
		Maps [[i]] <- input[which(input$chr==LGs[n]), c(1,3)]
}

## UNWEIGHTED LPmerge treats maps equally
	#unweighted <- LPmerge(Maps, max.interval= as.numeric(args[3]):as.numeric(args[4]))

## WEIGHTED LPmerge gives one map more weight than the other when there is a discrepancy
## This weight is based on how many markers are in each group
	## Counting markers in the LG from the 1st file
	file1 <- read.csv(args[1], header=T, as.is=T, check.names=F, sep=",")
	markers1 <- file1[which(file1$chr==LGs[n]), 1]
	m.count1 <- 0
	for (i in markers1) {
		m.count1 <- m.count1 + 1
	}
	print(paste(args [1], LGs[n], ":", m.count1, "markers"))

	## Counting markers in the LG from the 2nd file
	file2 <- read.csv(args[2], header=T, as.is=T, check.names=F, sep=",")
	markers2 <- file2[which(file2$chr==LGs[n]), 1]
	m.count2 <- 0
	for (i in markers2) {
		m.count2 <- m.count2 + 1
	}
	print(paste(args[2], LGs[n], ":", m.count2, "markers"))

	weight <- c(m.count1, m.count2)       ## list of the number of markers in each map
	weighted <- LPmerge(Maps, max.interval= as.numeric(args[3]):as.numeric(args[4]), weights= weight)
	print(weighted)
}
