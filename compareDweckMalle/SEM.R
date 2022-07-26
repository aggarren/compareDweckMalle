library(lavaan)
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
if (!exists ("df_dweck"))
  source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

calls <- c("RC1 ~ RC2 + RC3",
           "RC1 ~ RC3 + RC2",
           "RC1 ~ RC3",
           "RC1 ~ RC2",
           "RC2 ~ RC1 + RC3",
           "RC2 ~ RC3 + RC1",
           "RC2 ~ RC1",
           "RC2 ~ RC3",
           "RC3 ~ RC1 + RC2",
           "RC3 ~ RC2 + RC1",
           "RC3 ~ RC1",
           "RC3 ~ RC2")
all <- c()
for(call in 1:12){
  m_40_21 <- paste0('RC1 =~ V24 + V25 + V26 + V27 + V28 +
  V29 + V30 + V31 + V32 + V33 + V34 + V35 + V36 +
  V37 + V38 + V39 + V40
  RC2 =~ V11 + V12 + V13 + V14 + V15 + V16 + V17 +
  V18 + V19 + V20 + V21
  RC3 =~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9
                    ',calls[call])
  sem_40_21 <- sem(m_40_21,data=df_40_21,std.lv=TRUE)
  all_40_21 <- summary(sem_40_21,fit.measures=TRUE,standardized=TRUE)
  sum <- all_40_21
  all_40_21 <- as.data.frame(all_40_21$pe)
  all_40_21$call <- calls[call]
  all_40_21$aic <- sum$fit['aic']
  all <- rbind(all,all_40_21)
}
write.csv(all,paste0(dataDirectory,"semResults.csv"))
