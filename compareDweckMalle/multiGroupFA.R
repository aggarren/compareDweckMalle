library(lslx)
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
d_dweck <- df_dweck[,2:ncol(df_dweck)]
m_40_21 <- paste0('RC1 =~ hungry+pain+tired+fear+pleasure+computations+free_will+safe+desires+nauseated+calm+angry+intentions+self_aware
  RC2 =~ embarrassed+pride+love+guilt+beliefs+disrespected+depressed+emo_recog+joy+personality+happy+morality+self_restraint+thoughts
  RC3 =~ remembering+recognizing+temperature+communicating+seeing+depth+goal+sounds+choices+reasoning+odors')
lslx_mgfa <- lslx$new(model=m_40_21,data=df_dweck,
                      group_variable = "condition",
                      reference_group = "beetle")
lslx_mgfa$fit_backward()
lslx_mgfa$summarize(selector = "hbic")