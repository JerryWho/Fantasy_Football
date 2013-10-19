library(ggplot2)
library(RColorBrewer)
library(plyr)
library(xtable)
library(reshape)

fdat  <- read.delim("data/fantasyData.txt")
str(fdat)

#I want year to be a factor
fdat$year  <- factor(fdat$year, levels = c("2010", "2011", "2012"), ordered = TRUE)
str(fdat)
head(fdat)



#Find the highest fantasy scorer for each team, for each year using plyr
  
highestScorer  <- ddply(fdat, ~ year + Team + Position, summarize, Highest_Scorer = Name[which.max(FantasyPoints)], 
  FantasyPoints = max(FantasyPoints))

write.table(highestScorer, "data/highestScorer.txt",
  quote = FALSE, sep = "\t", row.names = FALSE)

scat_p  <- ggplot(subset(fdat, G >= max(G)/2), aes(x=Rush.Yds, y=Rec.Yds, color = Position, size = FantasyPoints)) + 
  geom_point(position =position_jitter(w=75, h=75)) + scale_color_brewer(palette = "Dark2") + 
  facet_wrap(~year) + ggtitle("ScatterPlot of Rushing Yards vs Receiving Yards")

print(scat_p)
ggsave("scatterplot_rush.yds_vs_rec.yds.png", path = "figures")


#Maybe try creating this scatterplot for each NFL team?
# Attempting to modify JB's code to make it work for me
d_ply(fdat, ~ Team, function(z) {
  theTeam <- z$Team[1]
  p <- ggplot(z, aes(x = Rush.Yds, y = Rec.Yds, color = Position, size = FantasyPoints)) +
    ggtitle(theTeam) + geom_point(position =position_jitter(w=75, h=75)) + 
    scale_color_brewer(palette = "Dark2")
  print(p)
  ggsave(paste0(theTeam, " Scatterplot of Receiving vs Rushing Yards.png"), path = ('figures/byTeam'))
})

  
#create facetted barchart (team), comparing contribution of highest fantasy points
  
bar_p  <- ggplot(highestScorer, aes(x=Position, y=FantasyPoints, fill=Position)) + geom_bar(stat="identity") + facet_wrap(~Team, ncol=8) +
  scale_fill_brewer(palette="Dark2") + ylab("Total Fantasy Points") + 
    ggtitle("Total Fantasy Points (2010-2012) by Highest Scorer per Position")

print(bar_p)
ggsave("bar_chart_total_fp_by_position_from_highest_scorers.png", path = 'figures') 

vp  <- ggplot(fdat, aes(x=Position, y=fpPergame)) + geom_violin(alpha=0.7) + facet_grid(year ~.) + 
  aes(fill=Position) + scale_fill_brewer(palette="Dark2") + ylab("Fantasy Points/Game") +
  ggtitle("Distribution of Fantasy Points/Game by Position and Year")

print(vp)
ggsave("violin_plot_fp_per_game_by_pos_year.png", path ='figures')

dev.off()








  

