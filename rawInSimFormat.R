fixLayout <- function(data){
  characters <- c("stapler","car","computer",
                  "robot","microbe","beetle",
                  "fish","bluejay","frog",
                  "mouse","goat","dog","bear",
                  "dolphin","elephant","chimp",
                  "fetus","pvs","infant","child",
                  "adult")
  byCharData <- c()
  byCharData <- rbind(byCharData,data[data$condition=="stapler",])
  
  #NEXT REARRANGE ITEMS TO SIMULATED DATA FORMAT
  byCharData <- cbind(data$goal,data$recognizing,data$choices,
                      data$seeing,data$depth,data$remembering,
                      data$communicating,
                      data$temperature,data$sounds,data$computations,
                      data$self_aware,data$depressed,data$reasoning,
                      data$self_restraint,data$emo_recog,
                      data$pride, data$disrespected, data$morality,
                      data$embarrassed, data$guilt, data$beliefs,
                      data$intentions,data$odors,data$free_will,
                      data$thoughts,data$personality,data$conscious,
                      data$love,data$angry,data$desires,data$nauseated,
                      data$joy,data$safe,data$happy,data$calm,data$pleasure,
                      data$fear,data$hungry,data$tired,data$pain)
  
  return (byCharData)
}
new <- fixLayout(read.csv("dweckRawData.csv"))
write.csv(new,"reformattedDweck.csv")
