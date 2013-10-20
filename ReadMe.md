Fantasy Football Data Analysis
========================================================

This repository was built to conduct data visualization and analysis of fantasy football from 2010 to 2012.

* The original data was found at [Nathan Brixius's Skydrive](https://skydrive.live.com/?cid=801f87a75bcb7685&id=801F87A75BCB7685%21466&authkey=%21AGiIqlHJtA4Hj5A).
* Jenny Bryan helped me organize and clean the data and her repository can be found [here](https://github.com/jennybc/nfl/).

The data files RB.txt, TE.txt, and WR.txt all the raw data files used to conduct this analysis.  It consists of three R scripts. 

1. *01_Merging_Data.R* - merges the data into one dataframe and computes the fantasy points and fantasy points per game for all players.
2. *02_Fantasy_Analysis.R* - creates ggplot2 graphs to help visualize the data
3. *Source_Script.R* - deletes all files created by the scripts and sources the other two scripts

In particular, this analysis seeks to compare the relative fantasy values of running backs (RB), wide receivers (WR) and tight ends (TE).









