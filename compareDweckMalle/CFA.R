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

m_40_21 <- 'RC1 =~ V24 + V25 + V26 + V27 + V28 +
V29 + V30 + V31 + V32 + V33 + V34 + V35 + V36 +
V37 + V38 + V39 + V40
RC2 =~ V11 + V12 + V13 + V14 + V15 + V16 + V17 +
V18 + V19 + V20 + V21
RC3 =~ V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9'
cfa_40_21 <- cfa(m_40_21,data=df_40_21,std.lv=TRUE)
all_40_21 <- summary(cfa_40_21,fit.measures=TRUE,standardized=TRUE)

m_16_21 <- 'RC1 =~ V1 + V2 + V3 + V4 + V5 + V6 + V7
RC2 =~ V8 + V10 + V11 + V13
RC3 =~ V12 + V14 + V15 + V16'
cfa_16_21 <- cfa(m_16_21,data=df_16_21,std.lv=TRUE)
all_16_21 <- summary(cfa_16_21,fit.measures=TRUE,standardized=TRUE)

m_40_3 <- 'RC1 =~ V16 + V17 + V18 + V19 + V20 +
V21 + V22 + V24 + V25 + V26 + V27 + V28 +
V29 + V30 + V31 + V32 + V33 + V34 + V35 + V36 +
V37 + V38 + V39 + V40
RC2 =~ V2 + V4 + V7 + V8 + V9
RC3 =~ V1 + V10 + V13 + V14'
cfa_40_3 <- cfa(m_40_3,data=df_40_3,std.lv=TRUE)
all_40_3 <- summary(cfa_40_3,fit.measures=TRUE,standardized=TRUE)

m_16_3 <- 'RC1 =~ V1 + V2 + V3 + V4 + V5 + V6 + V7
RC2 =~ V14 + V15 + V16
RC3 =~ V10 + V12 + V13'
cfa_16_3 <- cfa(m_16_3,data=df_16_3,std.lv=TRUE)
all_16_3 <- summary(cfa_16_3,fit.measures=TRUE,standardized=TRUE)

all_16_3$fit['cfi']
all_16_21$fit['cfi']
all_40_21$fit['cfi']
all_40_3$fit['cfi']

