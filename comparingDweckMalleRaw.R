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
d_malle <- d_malle[1:nrow(d_malle),1:ncol(d_malle)]
d_malle <- as.matrix(t(d_malle))
d_malle <- matrix(as.numeric(d_malle),ncol=ncol(d_malle))
d_dweck <- as.data.frame(d_dweck)
d_malle <- as.data.frame(d_malle[3:nrow(d_malle),])
d_dweck <- mutate_all(d_dweck,function(x) as.numeric(as.character(x)))
d_malle <- mutate_all(d_malle,function(x) as.numeric(as.character(x)))
## functions to analyze differences between two data sets
minimum <- function(data){
  results <- c()
  for(index in 1:nrow(data)){
    append(results,min(unlist(data[index,])))
  }
  return(results)
}
maximum <- function(data){
  results <- c()
  for(index in 1:nrow(data)){
    append(results,max(unlist(data[index,])))
  }
  return(results)
}
meanValue <- function(data){
  results <- c()
  for(index in 1:nrow(data)){
    append(results,mean(unlist(data[index,])))
  }
  return(results)
}
medianValue <- function(data){
  results <- c()
  for(index in 1:nrow(data)){
    append(results,median(unlist(data[index,])))
  }
  return(results)
}
standardDev <- function(data){
  results <- c()
  for(index in 1:nrow(data)){
    append(results,sd(unlist(data[index,])))
  }
  return(results)
}
analyze <- function(data1,data2){
  ##min
  min1 <- minimum(data1)
  min2 <- minimum(data2)
  ##max
  max1 <- maximum(data1)
  max2 <- maximum(data2)
  ##mean
  mean1 <- meanValue(data1)
  mean2 <- meanValue(data2)
  ##median
  median1 <- medianValue(data1)
  median2 <- medianValue(data2)
  ##standard deviation
  sd1 <- standardDev(data1)
  sd2 <- standardDev(data2)
  
  results1 <- data.frame(min1,max1,mean1,median1,sd1)
  results2 <- data.frame(min2,max2,mean2,median2,sd2)
  results <- results1-results2
  return(results)
}
## function to cycle through participants for all characters ---------------
strip <- function(matrix1,matrix2){
  listN <- c(17,23,22,22,20,19,20,20,21,18,20,24,20,22,21,21,20,21,19,20,21)
  index <- 1
  for(character in 1:length(listN)){
    N <- listN[character]
    currData1 <- matrix1[index:N,]
    currData2 <- matrix2[index:N,]
    index <- index + N
    results <- analyze(currData1,currData2)
    if(character == 1){ final <- results}
    else { final <- cbind(final,results)}
  }
  write.csv(final,paste0(dataDirectory,"comparison.csv"))
}
## perform analysis on data--------------------
strip(d_dweck,d_malle)