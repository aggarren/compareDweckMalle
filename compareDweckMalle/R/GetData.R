require(tidyverse)
require(lubridate)  ## for today()

########################
### Get Original file###
########################

dataFileNameDweck <- paste0(dataDirectory, "dweckRawData.csv")
df_dweck <- SafeReadCSV(dataFileNameDweck)  

dataFileNameMalle <- paste0(dataDirectory, "simulatedDataDweck.csv")
df_malle <- SafeReadCSV(dataFileNameMalle)  

dataFileName16_3 <- paste0(dataDirectory, "items16chars3.csv")
df_16_3 <- SafeReadCSV(dataFileName16_3)

dataFileName16_21 <- paste0(dataDirectory, "items16chars21.csv")
df_16_21 <- SafeReadCSV(dataFileName16_21)

dataFileName40_3 <- paste0(dataDirectory, "items40chars3.csv")
df_40_3 <- SafeReadCSV(dataFileName40_3)

dataFileName40_21 <- paste0(dataDirectory, "items40chars21.csv")
df_40_21 <- SafeReadCSV(dataFileName40_21)

dataFileNamebody <- paste0(dataDirectory, "body.csv")
df_body <- SafeReadCSV(dataFileNamebody)

dataFileNamebodyAffect <- paste0(dataDirectory, "bodyAffect.csv")
df_bodyAffect <- SafeReadCSV(dataFileNamebodyAffect)
