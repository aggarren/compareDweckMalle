library(dplyr)
library(tidyr)
library(stats)
library(knitr)

experimentName <- "compareDweckMalle"
myName <- Sys.info()[["user"]]
if (!exists("myName"))
  stop("Please enter who you are in R before running this code e.g., myName <- 'Greg'")
if (myName == "trafton")
  workingDirectory <- "~/Documents/graphics/AnnaGarren/"
if (myName == "garren")
  workingDirectory <- "~/Documents/capacities/compare/"
source(paste0(workingDirectory, experimentName,"R/helper.R"))
graphSaveDirectory <- paste0(workingDirectory, experimentName, "graphs/")
dataDirectory <- paste0(workingDirectory, experimentName, "/data/raw/")
processedDataDirectory <- paste0(workingDirectory, "data/processed/", experimentName, "/")
setwd(workingDirectory)
VerifyPathIsSafe(graphSaveDirectory)
VerifyPathIsSafe(dataDirectory)
VerifyPathIsSafe(processedDataDirectory)
if (!exists ("df_dweck") || !exists("df_malle"))
  source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

#make df_dweck items and characters match df_malle
data <- df_dweck
characters <- c("stapler","car","computer",
                "robot","microbe","beetle",
                "fish","blue jay","frog",
                "mouse","goat","dog","bear",
                "dolphin","elephant","chimpanzee",
                "fetus","person in a persistant vegetative state",
                "infant","child","adult")
for(index in 1:length(characters)){
  if(index == 1){ byCharData <- as.data.frame(data[data$condition==characters[index],])}
  else {
    byCharData <- rbind(byCharData,data[data$condition==characters[index],])
  }
}
#NEXT REARRANGE ITEMS TO SIMULATED DATA FORMAT
byCharData <- cbind(byCharData$goal,byCharData$recognizing,byCharData$choices,
                    byCharData$seeing,byCharData$depth,byCharData$remembering,
                    byCharData$communicating,
                    byCharData$temperature,byCharData$sounds,byCharData$computations,
                    byCharData$self_aware,byCharData$depressed,byCharData$reasoning,
                    byCharData$self_restraint,byCharData$emo_recog,
                    byCharData$pride, byCharData$disrespected, byCharData$morality,
                    byCharData$embarrassed, byCharData$guilt, byCharData$beliefs,
                    byCharData$intentions,byCharData$odors,byCharData$free_will,
                    byCharData$thoughts,byCharData$personality,byCharData$conscious,
                    byCharData$love,byCharData$angry,byCharData$desires,byCharData$nauseated,
                    byCharData$joy,byCharData$safe,byCharData$happy,byCharData$calm,byCharData$pleasure,
                    byCharData$fear,byCharData$hungry,byCharData$tired,byCharData$pain)

df_dweck <- byCharData
## prepare datasets for analysis --------------------------------------------------
d_dweck <- df_dweck[2:nrow(df_dweck),]
d_malle <- df_malle[,3:ncol(df_malle)]
d_dweck <- as.matrix(d_dweck)
d_dweck <- d_dweck[,1:ncol(d_dweck)]
d_dweck <- matrix(as.numeric(d_dweck),ncol=ncol(d_dweck))
d_malle <- d_malle[1:nrow(d_malle),1:ncol(d_malle)]
d_malle <- as.matrix(t(d_malle))
d_malle <- matrix(as.numeric(d_malle),ncol=ncol(d_malle))
d_dweck <- as.data.frame(d_dweck)
d_malle <- as.data.frame(d_malle)
d_dweck <- mutate_all(d_dweck,function(x) as.numeric(as.character(x)))
d_malle <- mutate_all(d_malle,function(x) as.numeric(as.character(x)))
#make malle on a scale of -3 to 3
d_malle[d_malle==0] <- -3
d_malle[d_malle==1] <- -2
d_malle[d_malle==2] <- -1
d_malle[d_malle==3] <- 0
d_malle[d_malle==4] <- 1
d_malle[d_malle==5] <- 2
d_malle[d_malle==6] <- 3
## functions to analyze differences between two data sets
minimum <- function(data){
  results <- c()
  for(index in 1:ncol(data)){
    results <- append(results,min(unlist(data[,index])))
  }
  return(results)
}
maximum <- function(data){
  results <- c()
  for(index in 1:ncol(data)){
    results <- append(results,max(unlist(data[,index])))
  }
  return(results)
}
meanValue <- function(data){
  results <- c()
  for(index in 1:ncol(data)){
    results <- append(results,mean(unlist(data[,index])))
  }
  return(results)
}
medianValue <- function(data){
  results <- c()
  for(index in 1:ncol(data)){
    results <- append(results,median(unlist(data[,index])))
  }
  return(results)
}
standardDev <- function(data){
  results <- c()
  for(index in 1:ncol(data)){
    results <- append(results,sd(unlist(data[,index])))
  }
  return(results)
}

performAnalysis <- function(data1,data2,character){
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
  results1 <- data.frame(min1, max1,mean1,median1,sd1)
  results2 <- data.frame(min2, max2,mean2,median2,sd2)
  results <- results1-results2
  return(results)
}
## function to cycle through participants for all characters ---------------
strip <- function(matrix1,matrix2){
  #listN1 and listN2 are same length
  listN1 <- c(17,23,22,22,20,19,20,20,21,18,20,24,20,22,21,21,20,21,19,20,21)
  listN2 <- c(17,23,22,22,20,19,20,20,21,18,20,24,20,22,21,21,20,21,19,20,21)
  index1 <- 1
  index2 <- 1
  for(character in 1:length(listN1)){
    N1 <- listN1[character]
    N2 <- listN2[character]
    currData1 <- matrix1[index1:N1,]
    currData2 <- matrix2[index2:N2,]
    index1 <- index1 + N1
    index2 <- index2 + N2
    results <- performAnalysis(currData1,currData2,character)
    if(character == 1){ 
      final <- results
    }
    else { final <- cbind(final,results)}
  }
  write.csv(final,paste0(dataDirectory,"comparison.csv"))
}
## perform analysis on data--------------------
strip(d_dweck,d_malle)
