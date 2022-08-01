
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
processedDataDirectory <- paste0(workingDirectory, experimentName, "/data/processed/", experimentName, "/")
setwd(workingDirectory)
VerifyPathIsSafe(graphSaveDirectory)
VerifyPathIsSafe(dataDirectory)
VerifyPathIsSafe(processedDataDirectory)
source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

df_16_3 <- df_16_3[,2:ncol(df_16_3)]
model_16_3 <- principal(df_16_3,nfactors=3,rotate="varimax")
sixteenThree <- model_16_3$loadings
write.csv(sixteenThree,paste0(processedDataDirectory,"sixteenThreeLoadings.csv"))

df_16_21 <- df_16_21[,2:ncol(df_16_21)]
model_16_21 <- principal(df_16_21,nfactors=3,rotate="varimax")
sixteenTwentyOne <- model_16_21$loadings
write.csv(sixteenTwentyOne,paste0(processedDataDirectory,"sixteenTwentyOneLoadings.csv"))

df_40_3 <- df_40_3[,2:ncol(df_40_3)]
model_40_3 <- principal(df_40_3,nfactors=3,rotate="varimax")
fourtyThree <- model_40_3$loadings
write.csv(fourtyThree,paste0(processedDataDirectory,"fourtyThreeLoadings.csv"))


df_40_21 <- df_40_21[,2:ncol(df_40_21)]
model_40_21 <- principal(df_40_21,nfactors=3,rotate="varimax")
fourtyTwentyOne <- model_40_21$loadings
write.csv(fourtyTwentyOne,paste0(processedDataDirectory,"fourtyTwentyOneLoadings.csv"))

df_body <- df_body[,2:ncol(df_body)]
model_body <- principal(df_body,nfactors=3,rotate="varimax")
body <- model_body$loadings
write.csv(body,paste0(processedDataDirectory,"bodyLoadings.csv"))

df_bodyAffect <- df_bodyAffect[,2:ncol(df_bodyAffect)]
model_bodyAffect <- principal(df_bodyAffect,nfactors=3,rotate="varimax")
bodyAffect <- model_bodyAffect$loadings
write.csv(bodyAffect,paste0(processedDataDirectory,"bodyAffectLoadings.csv"))

df_heart <- df_heart[,2:ncol(df_heart)]
model_heart <- principal(df_heart,nfactors=3,rotate="varimax")
heart <- model_heart$loadings
write.csv(heart,paste0(processedDataDirectory,"heartLoadings.csv"))

df_heartMoralMental <- df_heartMoralMental[,2:ncol(df_heartMoralMental)]
model_heartMoralMental <- principal(df_heartMoralMental,nfactors=1,rotate="varimax")
heartMoralMental <- model_heartMoralMental$loadings
write.csv(heartMoralMental,paste0(processedDataDirectory,"heartMoralMentalLoadings.csv"))

sixteenDifference <- sixteenThree - sixteenTwentyOne
fourtyDifference <- fourtyThree - fourtyTwentyOne
write.csv(sixteenDifference,paste0(processedDataDirectory,"sixteenDifference.csv"))
write.csv(fourtyDifference,paste0(processedDataDirectory,"fourtyDifference.csv"))