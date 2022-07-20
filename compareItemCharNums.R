library(psych)
data <- read.csv("items16chars3.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
sixteenThree <- model$loadings

data <- read.csv("items16chars21.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
sixteenTwentyOne <- model$loadings

data <- read.csv("items40chars3.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
fourtyThree <- model$loadings

data <- read.csv("items40chars21.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
fourtyTwentyOne <- model$loadings

sixteenDifference <- sixteenThree - sixteenTwentyOne
fourtyDifference <- fourtyThree - fourtyTwentyOne
sixteenDifference
#big difference when increasing character
  #3 to 21 when using 16 items
fourtyDifference 
#no difference when increasing character
  #3 to 21 when using 40 items