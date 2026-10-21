# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
 
# file paths 
files <- c( 
  "GO terms for all minitank1 time points.txt", 
  "GO terms for all minitank7 timepoints.txt" 
) 
 
# selected GO terms 
selected_terms <- c( 
  "GO:0009058", # biosynthetic process 
  "GO:0010467", # gene expression regulation 
  "GO:0006412", # translation 
  "GO:0016020", # membrane 
  "GO:0050896", # response to stimulus 
  "GO:0055114"  # oxidation-reduction process 
) 
 
# readable labels 
term_labels <- c( 
  "GO:0009058" = "GO:0009058 Biosynthetic process", 
  "GO:0010467" = "GO:0010467 Gene expression regulation", 
  "GO:0006412" = "GO:0006412 Translation", 
  "GO:0016020" = "GO:0016020 Membrane", 
  "GO:0050896" = "GO:0050896 Response to stimulus", 
  "GO:0055114" = "GO:0055114 Oxidation-reduction process" 
) 
 
 
 
 
 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
read_go_file <- function(file, tank_name) { 
  lines <- readLines(file, warn = FALSE) 
   
  current_time <- NA 
  out <- data.frame() 
   
  for (line in lines) { 
    line <- trimws(line) 
     
    if (line %in% c("T0:", "T2:", "T4:", "T7:")) { 
      current_time <- sub(":", "", line) 
      next 
    } 
     
    if (grepl("^[-0-9.eE]+\\s+GO:[0-9]+$", line) && !is.na(current_time)) { 
      parts <- strsplit(line, "\\s+")[[1]] 
      value <- as.numeric(parts[1]) 
      term <- parts[2] 
       
      if (term %in% selected_terms) { 
        out <- rbind(out, data.frame( 
          Tank = tank_name, 
          Timepoint = current_time, 
          GO = term, 
          Value = value 
        )) 
      } 
    } 
  } 
   
  out 
} 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
mt1 <- read_go_file(files[1], "MiniTank1") 
mt7 <- read_go_file(files[2], "MiniTank7") 
 
df <- rbind(mt1, mt7) 
df$Timepoint <- factor(df$Timepoint, levels = c("T0", "T2", "T4", "T7")) 
df$GO_label <- term_labels[df$GO] 
 
p <- ggplot(df, aes(x = Timepoint, y = Value, group = Tank, colour = Tank)) + 
  geom_line(linewidth = 0.9) + 
  geom_point(size = 2) + 
  facet_wrap(~ GO_label, scales = "free_y", ncol = 2) + 
  labs( 
    title = "Temporal trajectories of selected GO terms", 
    x = "Timepoint", 
    y = "Relative abundance (%)" 
  ) + 
  theme_minimal(base_size = 12) + 
  theme( 
    strip.text = element_text(face = "bold"), 
    panel.grid.minor = element_blank(), 
    legend.position = "top" 
  ) 
 
ggsave("GO_temporal_trends_selected.png", plot = p, width = 10, height = 12, dpi = 300)
