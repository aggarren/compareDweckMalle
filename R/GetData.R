require(tidyverse)
require(lubridate)  ## for today()

########################
### Get Original file###
########################

dataFileNameDweck <- paste0(dataDirectory, "reformattedDweck.csv")
d_dweck <- SafeReadCSV(dataFileNameDweck)  

dataFileNameMalle <- paste0(dataDirectory, "simulatedDataDweck.csv")
d_malle <- SafeReadCSV(dataFileNameMalle)  
