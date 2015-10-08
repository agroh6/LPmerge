#!/usr/bin/Rscript

## Creates a list called "Map" of the markers and cM for one LG from 
## two different maps. Uses LPmerge to make a consensus map.
## args 1 and 2 muxt have the file extension included in the input.

library("LPmerge")
args <- commandArgs(trailingOnly = TRUE)  # Allows you to add args in terminal
map.names <- c(args[1], args[2])          # Names of map files to combine
Maps <- list()
i <- 1

# for loop makes a list of markers and cMs for one LG to use in LPmerge function
for (i in 1:2) {
	input <- read.csv(map.names[i], header=T, as.is=T, check.names=F, sep=",")
	#print(input)
	Maps [[i]] <- input[which(input$chr==args[3]), c(1,3)]
}
#names(Maps) <- map.names
#str(Maps)

# UNWEIGHTED LPmerge treats maps equally
#unweighted <- LPmerge(Maps, max.interval= as.numeric(args[4]):as.numeric(args[5]))

# WEIGHTED LPmerge gives one map more weight than the other when there is a discrepancy
# This weight is based on how many markers are in each group
file1 <- read.csv(args[1], header=T, as.is=T, check.names=F, sep=",")
markers1 <- file1[which(file1$chr==args[3]), 1]
m.count1 <- 0
for (i in markers1) {
	m.count1 <- m.count1 + 1
}
print(paste(args [1], args[3], ":", m.count1, "markers"))

file2 <- read.csv(args[2], header=T, as.is=T, check.names=F, sep=",")
markers2 <- file2[which(file2$chr==args[3]), 1]
m.count2 <- 0
for (i in markers2) {
	m.count2 <- m.count2 + 1
}
print(paste(args[2], args[3], ":", m.count2, "markers"))

weight <- c(m.count1, m.count2)
weighted <- LPmerge(Maps, max.interval= as.numeric(args[4]):as.numeric(args[5]), weights= weight)
print(weighted)
