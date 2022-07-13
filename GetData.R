require(tidyverse)
require(lubridate)  ## for today()

########################
### Get Original file###
########################

dataFileNameDweck <- paste0(dataDirectory, "dweckRawData.csv")
d_dweck <- read.table(dataFileNameDweck)
d_dweck <- SafeReadCSV(dataFileNameDweck)  

dataFileNameMalle <- paste0(dataDirectory, "simulatedDataDweck.csv")
d_malle <- read.table(dataFileNameMalle)
d_malle <- SafeReadCSV(dataFileNameMalle)  
