library(psych)
data <- read.csv("items16chars3.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
sixteenThree <- model$loadings
write.csv(sixteenThree,"sixteenThreeLoadings.csv")

data <- read.csv("items16chars21.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
sixteenTwentyOne <- model$loadings
write.csv(sixteenTwentyOne,"sixteenTwentyOneLoadings.csv")

data <- read.csv("items40chars3.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
fourtyThree <- model$loadings
write.csv(fourtyThree,"fourtyThreeLoadings.csv")


data <- read.csv("items40chars21.csv")
data <- data[,2:ncol(data)]
model <- principal(data,nfactors=3)
fourtyTwentyOne <- model$loadings
write.csv(fourtyTwentyOne,"fourtyTwentyOneLoadings.csv")

sixteenDifference <- sixteenThree - sixteenTwentyOne
fourtyDifference <- fourtyThree - fourtyTwentyOne
write.csv(sixteenDifference,"sixteenDifference.csv")
write.csv(fourtyDifference,"fourtyDifference.csv")