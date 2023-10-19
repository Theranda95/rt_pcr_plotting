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
myh_fc <- read.csv("10_18_23_myh_log2fc.csv", stringsAsFactors = T) 

head(myh_fc)
tail(myh_fc)
str(myh_fc)
summary(myh_fc)

ggplot(myh_fc, aes(x = Genes, y =))

geom_bar(aes(x = genotype, y = percent_53BP1, fill = foci),
         position = "stack",
         stat = "identity", width=0.8) 

