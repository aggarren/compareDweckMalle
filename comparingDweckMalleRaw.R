# set up workspace -------------------------------------------------------------

# load libraries
library(dplyr)
library(tidyr)
library(psych)
library(stats)
library(knitr)


experimentName <- "comparing"
who <- "Anna"
if (who == "Greg")
  workingDirectory <- "~/Documents/graphics/AnnaGarren/"
if (who == "Anna")
  workingDirectory <- "~/Documents/capacities/"
source(paste0(workingDirectory, "R/helper.R"))
graphSaveDirectory <- paste0(workingDirectory, experimentName, "graphs/")
dataDirectory <- paste0(workingDirectory, experimentName, "/data/raw/")
processedDataDirectory <- paste0(workingDirectory, "data/processed/", experimentName, "/")
setwd(workingDirectory)
VerifyPathIsSafe(graphSaveDirectory)
VerifyPathIsSafe(dataDirectory)
VerifyPathIsSafe(processedDataDirectory)

if (!exists ("d_dweck") || !exists("d_malle"))
  source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

## prepare datasets for analysis --------------------------------------------------

d_dweck <- as.matrix(d_dweck)
d_dweck <- d_dweck[,2:ncol(d_dweck)]
d_dweck <- matrix(as.numeric(d_dweck),ncol=ncol(d_dweck))
d_malle <- as.matrix(t(d_malle))
d_malle <- d_malle[3:nrow(d_malle),1:ncol(d_malle)]
d_malle <- matrix(as.numeric(d_malle),ncol=ncol(d_malle))
d_dweck <- as.data.frame(d_dweck)
d_malle <- as.data.frame(d_malle)
## function to cycle through participants for all characters and gather stats ---------------
analyze <- function(matrix1,matrix2){
  listN <- c(17,23,22,22,20,19,20,20,21,18,20,24,20,22,21,21,20,21,19,20,21)
  index <- 1
  for(character in 1:length(listN)){
    N <- listN[character]
    currData1 <- matrix1[index:N,]
    currData2 <- matrix2[index:N,]
    index <- index + N
  }
}
## perform analysis on data
analyze(d_dweck,d_malle)
