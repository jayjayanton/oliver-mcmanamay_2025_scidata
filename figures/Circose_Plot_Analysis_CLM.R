library(circlize)
library(readxl)
library(igraph)
library(ggplot2)
library(dplyr)
library(tidyverse)

df <- read.csv("PFT_Appended_Wt_Prop.csv", row.names = 1)

# Compare graphs
par(mfrow=c(1,2))

##########################
### PFT Classification ### 
##########################

################################################
###  Select PFTs with Forest Classification  ###
################################################

Forest_df_select <- df %>% slice(30)
Forest_data <- as.matrix(Forest_df_select)

rownames(Forest_data) <- c("PFT 43")

Rf_border_mat = matrix(NA, nrow = nrow(Forest_data), ncol = ncol(Forest_data))
rownames(Rf_border_mat) = rownames(Forest_data)
colnames(Rf_border_mat) = colnames(Forest_data)
# Rf_border_mat[Forest_data >= .05] = "black"
# 
# grid.col = c('PFT 18' = "#9EF5BC80", "PFT 76" = "#88FD9180", 'Rainfed.Corn' = "#86110680", 'Rainfed.Soybeans' = "#C2C2FD80",
#              'Rainfed.Sorghum' = "#02DA3480",'Other.Arable.Land' = "#8F33D580",'Unmanaged.Pasture' = "#75C15480",
#              'Shrubland' = "#6DF15180",'Grassland' = "#8FF7E580",'Managed.Deciduous.Forest' = "#1A108280")


# Create a chord diagram 
chordDiagram(Forest_data, 
             transparency = 0.2,
             annotationTrack = c("grid"),
             annotationTrackHeight = c(0.05,0.05),
             link.lwd = 2,     # Line width
             link.lty = 2,
             preAllocateTracks = 1,
             link.largest.ontop = TRUE,
             big.gap = 10,
             small.gap = 0.5,
             link.visible = Forest_data >=0.05,
             link.sort =  TRUE,
             # link.decreasing = TRUE,
             # link.border = Rf_border_mat,
             # grid.col = grid.col,
             # row.col = c("#9EF5BC80","#88FD9180")
             group = NULL
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
                         if(abs(xplot[2] - xplot[1]) > 2){
                           circos.text(x = mean(xlim),
                                       y=4,
                                       labels = sector.name,
                                       # sector.index = "inside",
                                       facing = "outside",
                                       niceFacing = TRUE,
                                       adj = c(0,0),
                                       cex = 0.6,
                           )
                         }
                         # # Print axis
                         if(abs(xplot[2] - xplot[1]) > 2){
                           circos.axis(h="top", labels.cex = 0.5,
                                       #  sector.index = sector.name,
                                       track.index = 2, major.tick.length = 0.5)}
                       }, bg.border= NA
                         )

circos.clear()

### CLM Circose Plots

Forest_df_select <- df %>% slice(2,3,4,5,6,7)
Forest_data <- as.matrix(Forest_df_select)

rownames(Forest_data) <- c("PFT 2", "PFT 3", "PFT 6", "PFT 7", "PFT 8", "PFT 9")

Rf_border_mat = matrix(NA, nrow = nrow(Forest_data), ncol = ncol(Forest_data))
rownames(Rf_border_mat) = rownames(Forest_data)
colnames(Rf_border_mat) = colnames(Forest_data)
# Rf_border_mat[Forest_data >= .05] = "black"

# grid.col = c('PFT 18' = "#9EF5BC80", "PFT 76" = "#88FD9180", 'Rainfed.Corn' = "#86110680", 'Rainfed.Soybeans' = "#C2C2FD80",
#              'Rainfed.Sorghum' = "#02DA3480",'Other.Arable.Land' = "#8F33D580",'Unmanaged.Pasture' = "#75C15480",
#              'Shrubland' = "#6DF15180",'Grassland' = "#8FF7E580",'Managed.Deciduous.Forest' = "#1A108280")
# 

# Create a chord diagram 
chordDiagram(Forest_data, 
             transparency = 0.2,
             annotationTrack = c("grid"),
             annotationTrackHeight = c(0.05,0.05),
             link.lwd = 2,     # Line width
             link.lty = 2,
             preAllocateTracks = 1,
             link.largest.ontop = TRUE,
             big.gap = 10,
             small.gap = 0.5,
             link.visible = Forest_data >=0.05,
             link.sort =  TRUE,
             # link.decreasing = TRUE,
             # link.border = Rf_border_mat,
             # grid.col = grid.col,
             # row.col = c("#9EF5BC80","#88FD9180")
             group = NULL
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
                         if(abs(xplot[2] - xplot[1]) > 3){
                           circos.text(x = mean(xlim),
                                       y=4,
                                       labels = sector.name,
                                       # sector.index = "inside",
                                       facing = "outside",
                                       niceFacing = TRUE,
                                       adj = c(0,0),
                                       cex = 0.6,
                           )
                         }
                         # # Print axis
                         if(abs(xplot[2] - xplot[1]) > 3){
                           circos.axis(h="top", labels.cex = 0.5,
                                       #  sector.index = sector.name,
                                       track.index = 2, major.tick.length = 0.5)}
                       }, bg.border= NA
)

circos.clear()


grid.col = c('Irrigated.Corn' = "#A9D9EC80",
'Rainfed.Corn' = "#86110680",
'Irrigated.Spring.Wheat' = "#EE14AE80",
'Irrigated.Winter.Wheat' = "#10888280",
'Rainfed.Spring.Wheat' = "#CD5D1380",
'Rainfed.Winter.Wheat' = "#30DBB380",
'Irrigated.Potatoes' = "#A25ECA80",
'Irrigated.Soybeans' = "#33057A80",
'Irrigated.Sugarcane' = "#B8F8A580",
'Irrigated.Barley' = "#203DC180",
'Rainfed.Barley' = "#C69FFE80",
'Irrigated.Cotton' = "#A20BCE80",
'Rainfed.Cotton' = "#10030780",
'Irrigated.Sorghum' = "#FB98AD80",
'Irrigated.Alfalfa' = "#F1FE9080",
'Rainfed.Sorghum' = "#02DA3480",
'Irrigated.Peanuts' = "#D4FD7B80",
'Irrigated.Dry.Beans' = "#8D98EF80",
'Irrigated.Grapes' = "#DC784080",
'Irrigated.Citrus' = "#5991F480",
'Irrigated.Almonds' = "#F159D180",
'Irrigated.Oranges' = "#F7F61380",
'Rainfed.Oranges' = "#08F94780",
'Other.Arable.Land' = "#8F33D580",
'Managed.Pasture' = "#7AEDAF80",
'Unmanaged.Pasture' = "#75C15480",
'Managed.Deciduous.Forest' = "#1A108280",
'Managed.Evergreen.Forest' = "#0DA17F80",
'Managed.Mixed.Forest' = "#04108080",
'Unmanaged.Deciduous.Forest' = "#E1FD0A80",
'Unmanaged.Evergreen.Forest' = "#FEB6EF80",
'Unmanaged.Mixed.Forest' = "#12F5DC80",
'Shrubland' = "#6DF15180",
'Grassland' = "#8FF7E580",
'Open.Water' = "#B506D880",
'Woody.Wetlands' = "#7D970D80",
'Emergent.Herbaceous.Wetlands' = "#54F68880")

labels = c('Irrigated Corn',
           'Rainfed Corn',
           'Irrigated Spring.Wheat',
           'Irrigated Winter.Wheat',
           'Rainfed Spring.Wheat',
           'Rainfed Winter.Wheat',
           'Irrigated Potatoes',
           'Irrigated Soybeans',
           'Irrigated Sugarcane',
           'Irrigated Barley',
           'Rainfed Barley',
           'Irrigated Cotton',
           'Rainfed Cotton',
           'Irrigated Sorghum',
           'Irrigated Alfalfa',
           'Rainfed Sorghum',
           'Irrigated Peanuts',
           'Irrigated Dry Beans',
           'Irrigated Grapes',
           'Irrigated Citrus',
           'Irrigated Almonds',
           'Irrigated Oranges',
           'Rainfed Oranges',
           'Other Arable Land',
           'Managed Pasture',
           'Unmanaged Pasture',
           'Managed Deciduous Forest',
           'Managed Evergreen Forest',
           'Managed Mixed Forest',
           'Unmanaged Deciduous Forest',
           'Unmanaged Evergreen Forest',
           'Unmanaged Mixed Forest',
           'Shrubland',
           'Grassland',
           'Open Water',
           'Woody Wetlands',
           'Emergent Herbaceous Wetlands')

labels = c("1","2","3","4","5","6","7","8","9","10")

labels_sort = sort(labels)

# x_subset1 <- grep(labels_sort, labels, value = TRUE)
colfunc <- colorRampPalette(c("#C69FFE80", "#FEB6EF80")) 
# colfunc <- colorRampPalette(c("#EE14AE80", "#A20BCE80")) - Irrigated
# colfunc <- colorRampPalette(c("#08F94780", "#7AEDAF80")) - Rainf

plot(NULL)
legend("top", legend = labels, pch=15, pt.cex=2, cex=.9, bty='n',col = colfunc(10), ncol =1)



  