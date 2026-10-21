# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
 
files <- c( 
  "GO terms for all minitank1 time points.txt", 
  "GO terms for all minitank7 timepoints.txt" 
) 
 
selected_terms <- c( 
  "GO:0046677", # response to antibiotic 
  "GO:0006855", # drug transmembrane transport 
  "GO:0017000"  # antibiotic binding 
) 
 
term_labels <- c( 
  "GO:0046677" = "GO:0046677 Response to antibiotic", 
  "GO:0006855" = "GO:0006855 Drug transmembrane transport", 
  "GO:0017000" = "GO:0017000 Antibiotic binding" 
) 
 
read_go_file <- function(file, tank_name) { 
  lines <- readLines(file, warn = FALSE) 
  current_time <- NA 
  out <- data.frame( 
    Tank = character(), 
    Timepoint = character(), 
    GO = character(), 
    Value = numeric(), 
    stringsAsFactors = FALSE 
  ) 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
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
          Value = value, 
          stringsAsFactors = FALSE 
        )) 
      } 
    } 
  } 
 
  out 
} 
mt1 <- read_go_file(files[1], "MiniTank1") 
mt7 <- read_go_file(files[2], "MiniTank7") 
df <- rbind(mt1, mt7) 
# ensure all Tank x Timepoint x GO combinations exist 
all_combos <- expand.grid( 
Tank = c("MiniTank1", "MiniTank7"), 
Timepoint = c("T0", "T2", "T4", "T7"), 
GO = selected_terms, 
stringsAsFactors = FALSE 
) 
df <- merge(all_combos, df, by = c("Tank", "Timepoint", "GO"), all.x = TRUE) 
df$Timepoint <- factor(df$Timepoint, levels = c("T0", "T2", "T4", "T7")) 
df$GO_label <- term_labels[df$GO] 
p <- ggplot(df, aes(x = Timepoint, y = Value, group = Tank, colour = Tank)) + 
geom_line(linewidth = 1, na.rm = TRUE) + 
geom_point(size = 2.3, na.rm = TRUE) + 
facet_wrap(~ GO_label, scales = "free_y", ncol = 1) + 
labs( 
title = "Temporal trajectories of selected AMR-related GO terms", 
x = "Timepoint", 
y = "Relative abundance (%)" 
) + 
theme_minimal(base_size = 12) + 
theme( 
strip.text = element_text(face = "bold"), 
panel.grid.minor = element_blank(), 
legend.position = "top" 
) 
ggsave("GO_AMR_related_terms_final.png", plot = p, width = 8, height = 10, dpi = 300)
