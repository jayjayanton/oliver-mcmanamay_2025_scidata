library(circlize)
library(readxl)
library(igraph)
library(ggplot2)
library(dplyr)
library(tidyverse)

setwd("./Circose Plot Analysis/")

df <- read.csv("LUH2_Appended_Wt_Prop.csv.csv", row.names = 1)

# Compare graphs
par(mfrow=c(1,3))

##########################
### PFT Classification ### 
##########################


###  Select LUH Landcover Classification with C3 Annual Crops
Barren_df_select <- df %>% slice(6)
Barren_data <- as.matrix(Barren_df_select)

rownames(Barren_data) <- c("Urban")

Barren_border_mat = matrix(NA, nrow = nrow(Barren_data), ncol = ncol(Barren_data))
rownames(Barren_border_mat) = rownames(Barren_data)
colnames(Barren_border_mat) = colnames(Barren_data)
#Barren_border_mat[Barren_data >= .05] = "black"

# Create a chord diagram 
chordDiagram(Barren_data, 
             transparency = 0.2,
             annotationTrack = c("grid"),
             annotationTrackHeight = c(0.05,0.05),
             link.lwd = 2,     # Line width
             link.lty = 2,
             preAllocateTracks = 1,
             link.largest.ontop = TRUE,
             big.gap = 10,
             small.gap = 0.5,
             link.visible = Barren_data >=0.05,
             link.sort =  TRUE,
             # link.decreasing = TRUE,
             #link.border = Barren_border_mat,
             # grid.col = grid.col,
             row.col = 2
)

# Add labels and axis
circos.par(points.overflow.warning = FALSE)
circos.trackPlotRegion(track.index = 2, 
                       panel.fun = function(x, y) {
                         xlim = get.cell.meta.data("xlim")
                         ylim = get.cell.meta.data("ylim")
                         xplot = get.cell.meta.data("xplot")
                         sector.name = get.cell.meta.data("sector.index")
                         
                         # Print Labels
                         if(abs(xplot[2] - xplot[1]) > 3.5){
                           circos.text(x = mean(xlim),
                                       y=6,
                                       labels = sector.name,
                                       facing = "clockwise",
                                       niceFacing = TRUE,
                                       # adj = c(0.5,0),
                                       cex = 0.6, 
                           )
                         }
                         # # Print axis
                         if(abs(xplot[2] - xplot[1]) > 3.5){
                           circos.axis(h="top", labels.cex = 0.5,
                                       sector.index = sector.name, track.index = 2, major.tick.length = 0.5)}
                       }, bg.border= NA)

circos.clear()
