
# load libraries
library(dplyr)
library(tidyr)
library(psych)
library(stats)
library(knitr)
experimentName <- "compareSimilarities"
myName <- Sys.info()[["user"]]
if (!exists("myName"))
  stop("Please enter who you are in R before running this code e.g., myName <- 'Greg'")
if (myName == "trafton")
  workingDirectory <- "~/Documents/graphics/AnnaGarren/"
if (myName == "garren")
  workingDirectory <- "~/Documents/capacities/compare/"
source(paste0(workingDirectory, "R/helper.R"))
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
items16chars3 <- function(data){
  characters <- c("robot","child","adult")
  for(index in 1:length(characters)){
    if(index == 1){ byCharData <- as.data.frame(data[data$condition==characters[index],])}
    else {
      byCharData <- rbind(byCharData,data[data$condition==characters[index],])
    }
  }
  #NEXT REARRANGE ITEMS TO SIMULATED DATA FORMAT
  byCharData <- cbind(byCharData$choices,byCharData$communicating,
                      byCharData$temperature,byCharData$sounds,
                      byCharData$self_restraint,byCharData$emo_recog,
                      byCharData$morality,byCharData$beliefs,
                      byCharData$intentions,byCharData$thoughts,
                      byCharData$love,byCharData$angry,byCharData$desires,
                      byCharData$joy,byCharData$hungry,byCharData$pain)

  data <- byCharData
  ## prepare datasets for analysis --------------------------------------------------
  data <- data[2:nrow(data),]
  data <- data[,1:ncol(data)]
  data <- matrix(as.numeric(data),ncol=ncol(data))
  data <- as.data.frame(data)
  data <- mutate_all(data,function(x) as.numeric(as.character(x)))
  write.csv(data,paste0(dataDirectory,"items16chars3.csv"))
}
items16chars21 <- function(data){
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
  byCharData <- cbind(byCharData$choices,byCharData$communicating,
                      byCharData$temperature,byCharData$sounds,
                      byCharData$self_restraint,byCharData$emo_recog,
                      byCharData$morality,byCharData$beliefs,
                      byCharData$intentions,byCharData$thoughts,
                      byCharData$love,byCharData$angry,byCharData$desires,
                      byCharData$joy,byCharData$hungry,byCharData$pain)
  
  data <- byCharData
  ## prepare datasets for analysis --------------------------------------------------
  data <- data[2:nrow(data),]
  data <- as.matrix(data)
  data <- data[,1:ncol(data)]
  data <- matrix(as.numeric(data),ncol=ncol(data))
  data <- as.data.frame(data)
  data <- mutate_all(data,function(x) as.numeric(as.character(x)))
  
  write.csv(data,paste0(dataDirectory,"items16chars21.csv"))
}
items40chars3 <- function(data){
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
  
  data <- byCharData
  ## prepare datasets for analysis --------------------------------------------------
  data <- data[2:nrow(data),]
  data <- as.matrix(data)
  data <- data[,1:ncol(data)]
  data <- matrix(as.numeric(data),ncol=ncol(data))
  data <- as.data.frame(data)
  data <- mutate_all(data,function(x) as.numeric(as.character(x)))
  write.csv(data,paste0(dataDirectory,"items40chars3.csv"))
}
items40chars21 <- function(data){
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
  
  data <- byCharData
  ## prepare datasets for analysis --------------------------------------------------
  data <- data[2:nrow(data),]
  data <- as.matrix(data)
  data <- data[,1:ncol(data)]
  data <- matrix(as.numeric(data),ncol=ncol(data))
  data <- as.data.frame(data)
  data <- mutate_all(data,function(x) as.numeric(as.character(x)))
  write.csv(data,paste0(dataDirectory,"items40chars21.csv"))
}
df_dweck <- as.data.frame(df_dweck)
items16chars3(df_dweck)
items16chars21(df_dweck)
items40chars3(df_dweck)
items40chars21(df_dweck)
