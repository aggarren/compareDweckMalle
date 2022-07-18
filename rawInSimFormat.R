fixLayout <- function(data){
  characters <- c("stapler","car","computer",
                  "robot","microbe","beetle",
                  "fish","bluejay","frog",
                  "mouse","goat","dog","bear",
                  "dolphin","elephant","chimp",
                  "fetus","person in a persistant vegetative state",
                  "infant","child","adult")
  byCharData <- c()
  for(index in 1:length(characters)){
    byCharData <- rbind(byCharData,data[data$condition==characters[index],])
  }
  #NEXT REARRANGE ITEMS TO SIMULATED DATA FORMAT
  byCharData <- cbind(byCharData$goal,byCharData$recognizing,byCharData$choices,
                      byCharData$seeing,byCharData$depth,byCharData$remembering,
                      byCharData$communicating,
                      byCharData$temperature,byCharData$sounds,byCharData$computations,
                      byCharData$self_aware,byCharData$depressed,byCharData$reasoning,
                      byCharData$self_restraint,byCharData$emo_recog,
                      byCharData$pride, byCharData$disrespected, byCharData$morality,
                      byCharData$embarrassed, byCharData$guilt, byCharData$beliefs,
                      byCharData$intentions,byCharData$odors,byCharData$free_will,
                      byCharData$thoughts,byCharData$personality,byCharData$conscious,
                      byCharData$love,byCharData$angry,byCharData$desires,byCharData$nauseated,
                      byCharData$joy,byCharData$safe,byCharData$happy,byCharData$calm,byCharData$pleasure,
                      byCharData$fear,byCharData$hungry,byCharData$tired,byCharData$pain)
  
  write.csv(byCharData,"reformattedDweck.csv")
}
fixLayout(read.csv("dweckRawData.csv"))

