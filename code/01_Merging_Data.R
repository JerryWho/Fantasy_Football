
## Let's ignore the QB position for now , I want to start with the data that JB helped me produce in the last assigment and merge 
## the data so that RB, TE and WR are all in the datafram.  I am mostly interested in statistics that contribute to fantasy football scoring.

library(plyr)
library(gdata)

wrDat  <- read.delim('data/WR.txt')
wrDat$Position = "WR"

rbDat  <- read.delim('data/RB.txt')
rbDat$Position = "RB"

teDat <- read.delim('data/TE.txt')
teDat$Position ="TE"

dat <- list(teDat,rbDat,wrDat)

tokeep  <- c("Name", 'Team', 'G', 'Rec', 'Targets', 'Rec.Yds', 'Rec.YG', 'Rec.Avg', 'YAC', 'Rec.TD', 'Rush', 'Rush.Yds', 'Rush.Avg', 'Rush.TD', 'FumL', 'year', 'Position')

trimDF  <- function(df){
  df  <- df[,which(colnames(df) %in% tokeep)]
  return (df)
}

dat  <- llply(dat, trimDF)


#Help from Stackoverflow (http://stackoverflow.com/questions/8091303/merge-multiple-data-frames-in-a-list-simultaneously)
mergedDat = Reduce(function(...) merge(..., all=T), dat)

##Let's Calculate Fantasy Points (Points are based on standard scoring leagues with no bonus points)
ydpoints  <- 10
tdpoints  <- 6
fumlpoints  <- -2

fantColNames  <- c("Rec.Yds", "Rush.Yds", "Rec.TD", "Rush.TD")

mergedDat[,which(colnames(mergedDat) %in% fantColNames)][is.na(mergedDat[,which(colnames(mergedDat) %in% fantColNames)])] <- 0

mergedDat$FantasyPoints = with(mergedDat, (Rec.Yds + Rush.Yds)/ydpoints + (Rec.TD + Rush.TD) * 
  tdpoints + FumL * fumlpoints, na.rm=F)

##Since total fantasy points is affected by number of games played, it might be better to look at fantasy points per game
mergedDat$fpPergame  <- mergedDat$FantasyPoints/mergedDat$G

##Trim whitespace in front of names
mergedDat  <- trim(mergedDat)
str(mergedDat)
head(mergedDat)

#order by name
mergedDat  <- mergedDat[order(mergedDat$Name),]

##Write new data set to file

write.table(mergedDat, "data/fantasyData.txt",
  quote = FALSE, sep = "\t", row.names = FALSE)





