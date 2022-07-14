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
  
  return (byCharData)
}
new <- fixLayout(read.csv("dweckRawData.csv"))
