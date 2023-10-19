##Plotting FC for KO2/WT26 samples for myh1, myh2 and myh7 
  #data from qPCR and RNA-seq analysis as Log2FC

#Load packages 
library(data.table) #needed to run function
library(dplyr) #needed to combine matrices 
library(ggplot2) #needed for graphing 
library(ggpubr) #needed for stats tests 
library(ggbeeswarm)

getwd()
setwd("~/Documents/experiments_2023/12_sept_23_RNA_Seq_Analysis/qPCR_validations")
myh_fc <- read.csv("10_18_23_ko2_log2fc.csv", stringsAsFactors = T) 

head(myh_fc)
tail(myh_fc)
str(myh_fc)
summary(myh_fc)

##---------------plotting for black background ---------------------

ko2_wt26_fc <- ggplot(myh_fc, aes(x = Method, y =Log2FC, fill = Method)) +
  #indicate what plot you want and define characteristics 
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean",  #bar goes up to the mean
           width = 0.7) +
  #group data into facets for the different genes 
  facet_grid(~Genes) +
  #Add mean point and error bars using stat summary
  stat_summary(fun.y = mean,
               geom = "point",
               size = 2,
               color = "grey") +
  stat_summary(fun.data = mean_sd,
               geom = "errorbar",
               width = 0.25,
               color = "grey") +
  #change axis titles and themes
  theme_minimal() +
  theme(panel.grid = element_line(color = "#555555")) + #changing the color of the grid to fit better in a black background 
  labs(x = NULL, y = "Log2FC",
       title = "KO2/WTB") +
  #scale_x_discrete(labels = custom_labels) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 10, color = "#F0F0F0"),
        axis.title.y = element_text(size = 13, color = "#F0F0F0"),
        axis.text.y = element_text(color = "#F0F0F0"),
        strip.text = element_text(size = 14, color = "#F0F0F0"),
        plot.title = element_text(size=17, hjust=0.5, color = "#F0F0F0"),
        legend.position = "none") +
  scale_fill_manual(values = c("#0072B2","#CC79A7"))

## Save the plot in the current directory 
setwd("/Users/therandajashari/Documents/experiments_2023/12_sept_23_RNA_Seq_Analysis/qPCR_validations/")
getwd()
ggsave(filename = "myh_ko2_log2fc.png", plot = ko2_wt26_fc, device = "png", bg = "transparent", width = 4.09, height = 3.56)










