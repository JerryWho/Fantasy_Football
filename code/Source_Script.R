##Code to run both of my scripts that creates by new data & figures

#Delete the previously created files
todelete <- c("data/fantasyData.txt",  "data/highestScorer.txt",  
  list.files(path="figures", recursive=TRUE, full.names=TRUE))
file.remove(todelete)

## run my scripts
source("code/01_Merging_Data.R")
source("code/02_Fantasy_Analysis.R")