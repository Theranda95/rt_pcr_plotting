##Plotting deltaCT for KO2/WT26 samples for myh1, myh2 and myh7 
#data from qPCR as 2^-deltaCt

#Load packages 
library(data.table) #needed to run function
library(dplyr) #needed to combine matrices 
library(ggplot2) #needed for graphing 
library(ggpubr) #needed for stats tests 
library(ggbeeswarm)

getwd()
setwd("~/Documents/experiments_2023/12_sept_23_RNA_Seq_Analysis/qPCR_validations")
myh_rel <- read.csv("10_18_23_myh_relative.csv", stringsAsFactors = T) 

head(myh_rel)
tail(myh_rel)
str(myh_rel)
summary(myh_rel)

custom_labels<- c("WT A", "WT B", "CFL2 KO1", "CFL2 KO2")
blue_palette <- c("#A9CCE3", "#7FB3D5", "#5499C7", "#0059b3")
myh_rel$Genotype <- factor(myh_rel$Genotype, levels = c("WT25", "WT26", "KO1", "KO2"))

# Plot MYH1, MYH2 and MYH7 relative expression in a grouped bar graph with error bars:
#Use geom_col() instead of geom_bar() for heights of the bar representing values in the data. 
#geom_bar() more often used for histograms 

##---------------plotting for black background ---------------------

rel_plot <- ggplot(myh_rel, aes (x = Genotype, y = FC, fill = Genotype)) +
  #indicate what plot you want and define characteristics 
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean",  #bar goes up to the mean
           width = 0.8) +
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
  labs(x = NULL, y = "Relative to RPS18 expression") +
  scale_x_discrete(labels = custom_labels) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 10, color = "#F0F0F0"),
        axis.title.y = element_text(size = 13, color = "#F0F0F0"),
        axis.text.y = element_text(color = "#F0F0F0"),
        strip.text = element_text(size = 14, color = "#F0F0F0"),
        legend.position = "none") +
  scale_fill_manual(values = c("#7FB3D5","#7FB3D5","#0059b3","#0059b3")) 
  
  
## Save the graph 
setwd("/Users/therandajashari/Documents/experiments_2023/12_sept_23_RNA_Seq_Analysis/qPCR_validations/rt_pcr_plotting")
getwd()
ggsave(filename = "myh_relative_exp.png", plot = rel_plot, device = "png", bg = "transparent", width = 4.69, height = 3.59)

##------------------------ Notes --------------------------------   
    ##I am dividing the data by facets here but it can also be divided into a grouped
    # bar plot, however adding error bars in the grouped data and or points 
    # needs more work 






