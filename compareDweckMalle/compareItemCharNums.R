
# load libraries
library(dplyr)
library(tidyr)
library(psych)
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
source(paste0(workingDirectory, experimentName,"/R/helper.R"))
graphSaveDirectory <- paste0(workingDirectory, experimentName, "graphs/")
dataDirectory <- paste0(workingDirectory, experimentName, "/data/raw/")
processedDataDirectory <- paste0(workingDirectory, "data/processed/", experimentName, "/")
setwd(workingDirectory)
VerifyPathIsSafe(graphSaveDirectory)
VerifyPathIsSafe(dataDirectory)
VerifyPathIsSafe(processedDataDirectory)
if (!exists ("df_16_3"))
  source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

df_16_3 <- df_16_3[,2:ncol(df_16_3)]
model_16_3 <- principal(df_16_3,nfactors=3)
sixteenThree <- model_16_3$loadings
write.csv(sixteenThree,paste0(processedDataDirectory,"sixteenThreeLoadings.csv"))

df_16_21 <- df_16_21[,2:ncol(df_16_21)]
model_16_21 <- principal(df_16_21,nfactors=3)
sixteenTwentyOne <- model_16_21$loadings
write.csv(sixteenTwentyOne,paste0(processedDataDirectory,"sixteenTwentyOneLoadings.csv"))

df_40_3 <- df_40_3[,2:ncol(df_40_3)]
model_40_3 <- principal(df_40_3,nfactors=3)
fourtyThree <- model_40_3$loadings
write.csv(fourtyThree,paste0(processedDataDirectory,"fourtyThreeLoadings.csv"))


df_40_21 <- df_40_21[,2:ncol(df_40_21)]
model_40_21 <- principal(df_40_21,nfactors=3)
fourtyTwentyOne <- model_40_21$loadings
write.csv(fourtyTwentyOne,paste0(processedDataDirectory,"fourtyTwentyOneLoadings.csv"))

sixteenDifference <- sixteenThree - sixteenTwentyOne
fourtyDifference <- fourtyThree - fourtyTwentyOne
write.csv(sixteenDifference,paste0(processedDataDirectory,"sixteenDifference.csv"))
write.csv(fourtyDifference,paste0(processedDataDirectory,"fourtyDifference.csv"))