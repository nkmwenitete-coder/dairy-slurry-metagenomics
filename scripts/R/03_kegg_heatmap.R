# Extracted from dissertation code appendix; not independently executed or validated.
library(pheatmap) 
files <- c( 
  "minitank1/KEGG_norm.txt", 
  "minitank2/KEGG_norm.txt", 
  "minitank3/KEGG_norm.txt", 
  "minitank4/KEGG_norm.txt", 
  "minitank5/KEGG_norm.txt", 
  "minitank6/KEGG_norm.txt", 
  "minitank7/KEGG_norm.txt", 
  "minitank8/KEGG_norm.txt" 
) 
sample_names <- c( 
  "MiniTank1_T0", 
  "MiniTank7_T0", 
  "MiniTank1_T2", 
  "MiniTank7_T2", 
  "MiniTank1_T4", 
  "MiniTank7_T4", 
  "MiniTank1_T7", 
  "MiniTank7_T7" 
) 
mat_list <- list() 
 
for (i in seq_along(files)) { 
  df <- read.table(files[i], header = FALSE, stringsAsFactors = FALSE) 
  colnames(df) <- c("Value", "Pathway") 
  df$Value <- as.numeric(df$Value) 
  df <- df[!is.na(df$Value), ] 
  df <- aggregate(Value ~ Pathway, df, sum) 
  mat_list[[i]] <- df 
} 
 
all_pathways <- Reduce(union, lapply(mat_list, function(x) x$Pathway)) 
 
mat <- matrix(0, nrow = length(all_pathways), ncol = length(mat_list)) 
rownames(mat) <- all_pathways 
colnames(mat) <- sample_names 
 
for (i in seq_along(mat_list)) { 
  df <- mat_list[[i]] 
  mat[df$Pathway, i] <- df$Value 
} 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
vars <- apply(mat, 1, var) 
vars <- vars[vars > 0] 
mat <- mat[names(vars), ] 
 
top100_names <- names(sort(vars, decreasing = TRUE))[1:100] 
top100 <- mat[top100_names, ] 
 
annotation_col <- data.frame( 
  Tank = c("MiniTank1", "MiniTank7", "MiniTank1", "MiniTank7", 
           "MiniTank1", "MiniTank7", "MiniTank1", "MiniTank7"), 
  Timepoint = c("T0", "T0", "T2", "T2", "T4", "T4", "T7", "T7") 
) 
 
rownames(annotation_col) <- colnames(top100) 
 
annotation_colors <- list( 
  Tank = c(MiniTank1 = "#1f78b4", MiniTank7 = "#e31a1c"), 
  Timepoint = c(T0 = "#bdbdbd", T2 = "#66c2a5", T4 = "#fc8d62", T7 = "#8da0cb") 
) 
 
png("KEGG_top100_heatmap_final.png", width = 2000, height = 2600, res = 250) 
 
pheatmap( 
  top100, 
  scale = "row", 
  fontsize_row = 4, 
  fontsize_col = 10, 
  border_color = NA, 
  annotation_col = annotation_col, 
  annotation_colors = annotation_colors, 
  main = "Top 100 most variable KEGG pathways across mini-tank samples" 
) 
 
dev.off()
