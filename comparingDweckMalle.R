# set up workspace -------------------------------------------------------------

# load libraries
library(dplyr)
library(tidyr)
library(psych)
library(stats)
library(knitr)
experimentName <- "compareDweckMalle"
myName <- Sys.info()[["user"]]
if (!exists("myName"))
  stop("Please enter who you are in R before running this code e.g., myName <- 'Greg'")
if (myName == "trafton")
  workingDirectory <- "~/Documents/graphics/AnnaGarren/"
if (myName == "garren")
  workingDirectory <- "~/Documents/capacities/compare/"
source(paste0(workingDirectory, "R/helper.R"))
graphSaveDirectory <- paste0(workingDirectory, experimentName, "graphs/")
dataDirectory <- paste0(workingDirectory, experimentName, "/data/raw/")
processedDataDirectory <- paste0(workingDirectory, "data/processed/", experimentName, "/")
setwd(workingDirectory)
VerifyPathIsSafe(graphSaveDirectory)
VerifyPathIsSafe(dataDirectory)
VerifyPathIsSafe(processedDataDirectory)
if (!exists ("df_dweck") || !exists("df_malle"))
  source(paste0(workingDirectory, experimentName, "/R/", "GetData.R"))

## prepare datasets for analysis --------------------------------------------------
d_dweck <- df_dweck
d_malle <- df_malle
d_dweck <- as.matrix(d_dweck)
d_dweck <- d_dweck[,2:ncol(d_dweck)]
d_dweck <- matrix(as.numeric(d_dweck),ncol=ncol(d_dweck))
d_malle <- d_malle[1:nrow(d_malle),1:ncol(d_malle)]
d_malle <- as.matrix(t(d_malle))
d_malle <- matrix(as.numeric(d_malle),ncol=ncol(d_malle))
d_dweck <- as.data.frame(d_dweck)
d_malle <- as.data.frame(d_malle[2:nrow(d_malle),])
d_dweck <- mutate_all(d_dweck,function(x) as.numeric(as.character(x)))
d_malle <- mutate_all(d_malle,function(x) as.numeric(as.character(x)))
d_malle <- d_malle[2:nrow(d_malle),]
d_dweck <- d_dweck[2:nrow(d_dweck),]
#make malle on a scale of -3 to 3
d_malle[d_malle==0] <- -3
d_malle[d_malle==1] <- -2
d_malle[d_malle==2] <- -1
d_malle[d_malle==3] <- 0
d_malle[d_malle==4] <- 1
d_malle[d_malle==5] <- 2
d_malle[d_malle==6] <- 3


# PCA: dweck condition --------------------------------------------------------

## step 3: run pca with varimax rotation with N dimensions -------------------

# run pca with n dimensions with varimax rotation
pca_dweck_rotatedN <- principal(d_dweck, nfactors = 3,
                                 rotate = "varimax")
pca_dweck_rotatedN

# plot mental capacities in first two dimensions
pca_dweck_rotatedN_loadings <-
  data.frame(pca_dweck_rotatedN$loadings[1:40, 1:3],
             row.names = rownames(pca_dweck_rotatedN$loadings[1:40, 1:3]))

# code a priori mental capacity categories
pca_dweck_rotatedN_loadings[c("hungry", "tired", "pain",
                               "nauseated", "safe"),
                             "mc_cat"] <- "biological"
pca_dweck_rotatedN_loadings[c("happy", "depressed", "fear",
                               "angry", "calm", "joy"),
                             "mc_cat"] <- "affective"
pca_dweck_rotatedN_loadings[c("sounds", "seeing", "temperature",
                               "odors", "depth"),
                             "mc_cat"] <- "perceptual"
pca_dweck_rotatedN_loadings[c("computations", "thoughts", "reasoning",
                               "remembering", "beliefs"),
                             "mc_cat"] <- "cognitive"
pca_dweck_rotatedN_loadings[c("free_will", "choices", "self_restraint",
                               "intentions", "goal"),
                             "mc_cat"] <- "autonomous"
pca_dweck_rotatedN_loadings[c("love", "recognizing", "communicating", "guilt",
                               "disrespected", "embarrassed", "emo_recog"),
                             "mc_cat"] <- "social"
pca_dweck_rotatedN_loadings[c("conscious", "self_aware", "pleasure",
                               "desires", "morality", "personality", "pride"),
                             "mc_cat"] <- "other"

pca_dweck_rotatedN_loadings$mc_cat <- factor(pca_dweck_rotatedN_loadings$mc_cat)

# examine loadings
mc_dweck_rotatedN = rownames(pca_dweck_rotatedN_loadings)

# ... for RC1
pca_dweck_rotatedN_pc1 <- pca_dweck_rotatedN_loadings %>%
  mutate(mc = mc_dweck_rotatedN) %>%
  arrange(desc(RC1)) %>%
  select(RC1, mc, mc_cat)
pca_dweck_rotatedN_pc1

# ... for RC2
pca_dweck_rotatedN_pc2 <- pca_dweck_rotatedN_loadings %>%
  mutate(mc = mc_dweck_rotatedN) %>%
  arrange(desc(RC2)) %>%
  select(RC2, mc, mc_cat)
pca_dweck_rotatedN_pc2

# ... for RC3
pca_dweck_rotatedN_pc3 <- pca_dweck_rotatedN_loadings %>%
  mutate(mc = mc_dweck_rotatedN) %>%
  arrange(desc(RC3)) %>%
  select(RC3, mc, mc_cat)
pca_dweck_rotatedN_pc3

# PCA: malle condition ---------------------------------------------------------

## step 3: run pca with varimax rotation with N dimensions -------------------

# run pca with n dimensions with varimax rotation
pca_malle_rotatedN <- principal(d_malle, nfactors = 3,
                                rotate = "varimax")
pca_malle_rotatedN
pca_malle_rotatedN_loadings <- as.data.frame.matrix(pca_malle_rotatedN$loadings)
# code a priori mental capacity categories
pca_malle_rotatedN_loadings[c(38, 39, 40, 31, 33), "mc_cat"] <- "biological"
#"hungry", "tired", "pain",  "nauseated", "safe"
pca_malle_rotatedN_loadings[c(34, 12, 37,  29, 35, 32), "mc_cat"] <- "affective"
#"happy", "depressed", "fear", "angry", "calm", "joy"
pca_malle_rotatedN_loadings[c(9, 4, 8, 23, 5),"mc_cat"] <- "perceptual"
#"sounds", "seeing", "temperature", "odors", "depth"
pca_malle_rotatedN_loadings[c(10, 25, 13,6, 21), "mc_cat"] <- "cognitive"
#"computations", "thoughts", "reasoning", "remembering", "beliefs"
pca_malle_rotatedN_loadings[c(24, 3, 14, 22, 1),"mc_cat"] <- "autonomous"
#"free_will", "choices", "self_restraint", "intentions", "goal"
pca_malle_rotatedN_loadings[c(28, 2, 7, 20,17, 19, 15),"mc_cat"] <- "social"
#"love", "recognizing", "communicating", "guilt", "disrespected", "embarrassed", "emo_recog"
pca_malle_rotatedN_loadings[c(27, 11, 36,30, 18, 26, 16),"mc_cat"] <- "other"
#"conscious", "self_aware", "pleasure", "desires", "morality", "personality", "pride"
pca_malle_rotatedN$mc_cat <- factor(pca_malle_rotatedN$mc_cat)
# examine loadings
mc_malle_rotatedN = rownames(pca_malle_rotatedN_loadings)

# ... for RC1
pca_malle_rotatedN_pc1 <- pca_malle_rotatedN_loadings %>%
  mutate(mc = mc_malle_rotatedN) %>%
  arrange(desc(RC1)) %>%
  select(RC1, mc, mc_cat)
pca_malle_rotatedN_pc1

# ... for RC2
pca_malle_rotatedN_pc2 <- pca_malle_rotatedN_loadings %>%
  mutate(mc = mc_malle_rotatedN) %>%
  arrange(desc(RC2)) %>%
  select(RC2, mc, mc_cat)
pca_malle_rotatedN_pc2

# ... for RC3
pca_malle_rotatedN_pc3 <- pca_malle_rotatedN_loadings %>%
  mutate(mc = mc_malle_rotatedN) %>%
  arrange(desc(RC3)) %>%
  select(RC3, mc, mc_cat)
pca_malle_rotatedN_pc3

# compare dimensions across conditions -----------------------------------------

# get top 10 factor loadings by conditions and dimension (absolute value)
dweck_rotatedN_top10_pc1 <- pca_dweck_rotatedN_pc1 %>%
  mutate(abs_RC1 = abs(RC1),
         valence = factor(ifelse(RC1 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC1)

dweck_rotatedN_top10_pc2 <- pca_dweck_rotatedN_pc2 %>%
  mutate(abs_RC2 = abs(RC2),
         valence = factor(ifelse(RC2 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC2)

dweck_rotatedN_top10_pc3 <- pca_dweck_rotatedN_pc3 %>%
  mutate(abs_RC3 = abs(RC3),
         valence = factor(ifelse(RC3 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC3)

malle_rotatedN_top10_pc1 <- pca_malle_rotatedN_pc1 %>%
  mutate(abs_RC1 = abs(RC1),
         valence = factor(ifelse(RC1 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC1)

malle_rotatedN_top10_pc2 <- pca_malle_rotatedN_pc2 %>%
  mutate(abs_RC2 = abs(RC2),
         valence = factor(ifelse(RC2 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC2)

malle_rotatedN_top10_pc3 <- pca_malle_rotatedN_pc3 %>%
  mutate(abs_RC3 = abs(RC3),
         valence = factor(ifelse(RC3 < 0, "neg", "pos"))) %>%
  top_n(10, abs_RC3)

# compare all possible combinations (across conditions)
match_rotated_dweckRC1_malleRC1 <-
  dweck_rotatedN_top10_pc1 %>%
  mutate(comparison = "dweckRC1_malleRC1") %>%
  filter(dweck_rotatedN_top10_pc1$mc %in% malle_rotatedN_top10_pc1$mc)

match_rotated_dweckRC1_malleRC2 <-
  dweck_rotatedN_top10_pc1 %>%
  mutate(comparison = "dweckRC1_malleRC2") %>%
  filter(dweck_rotatedN_top10_pc1$mc %in% malle_rotatedN_top10_pc2$mc)

match_rotated_dweckRC1_malleRC3 <-
  dweck_rotatedN_top10_pc1 %>%
  mutate(comparison = "dweckRC1_malleRC3") %>%
  filter(dweck_rotatedN_top10_pc1$mc %in% malle_rotatedN_top10_pc3$mc)

match_rotated_dweckRC2_malleRC1 <-
  dweck_rotatedN_top10_pc2 %>%
  mutate(comparison = "dweckRC2_malleRC1") %>%
  filter(dweck_rotatedN_top10_pc2$mc %in% malle_rotatedN_top10_pc1$mc)

match_rotated_dweckRC2_malleRC2 <-
  dweck_rotatedN_top10_pc2 %>%
  mutate(comparison = "dweckRC2_malleRC2") %>%
  filter(dweck_rotatedN_top10_pc2$mc %in% malle_rotatedN_top10_pc2$mc)

match_rotated_dweckRC2_malleRC3 <-
  dweck_rotatedN_top10_pc2 %>%
  mutate(comparison = "dweckRC2_malleRC3") %>%
  filter(dweck_rotatedN_top10_pc2$mc %in% malle_rotatedN_top10_pc3$mc)

match_rotated_dweckRC3_malleRC1 <-
  dweck_rotatedN_top10_pc3 %>%
  mutate(comparison = "dweckRC3_malleRC1") %>%
  filter(dweck_rotatedN_top10_pc3$mc %in% malle_rotatedN_top10_pc1$mc)

match_rotated_dweckRC3_malleRC2 <-
  dweck_rotatedN_top10_pc3 %>%
  mutate(comparison = "dweckRC3_malleRC2") %>%
  filter(dweck_rotatedN_top10_pc3$mc %in% malle_rotatedN_top10_pc2$mc)

match_rotated_dweckRC3_malleRC3 <-
  dweck_rotatedN_top10_pc3 %>%
  mutate(comparison = "dweckRC3_malleRC3") %>%
  filter(dweck_rotatedN_top10_pc3$mc %in% malle_rotatedN_top10_pc3$mc)

match_rotated <- match_rotated_dweckRC1_malleRC1 %>%
  full_join(match_rotated_dweckRC1_malleRC2) %>%
  full_join(match_rotated_dweckRC1_malleRC3) %>%
  full_join(match_rotated_dweckRC2_malleRC1) %>%
  full_join(match_rotated_dweckRC2_malleRC2) %>%
  full_join(match_rotated_dweckRC2_malleRC3) %>%
  full_join(match_rotated_dweckRC3_malleRC1) %>%
  full_join(match_rotated_dweckRC3_malleRC2) %>%
  full_join(match_rotated_dweckRC3_malleRC3)

top_match_rotated <- match_rotated %>%
  count(comparison) %>%
  arrange(desc(n)) %>%
  left_join(match_rotated) %>%
  select(comparison, n, mc)

