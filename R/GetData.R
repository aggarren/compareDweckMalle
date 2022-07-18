require(tidyverse)
require(lubridate)  ## for today()

########################
### Get Original file###
########################

dataFileNameDweck <- paste0(dataDirectory, "reformattedDweck.csv")
df_dweck <- SafeReadCSV(dataFileNameDweck)  

dataFileNameMalle <- paste0(dataDirectory, "simulatedDataDweck.csv")
df_malle <- SafeReadCSV(dataFileNameMalle)  
