# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
df <- data.frame( 
  Timepoint = rep(c("T0", "T2", "T4", "T7"), times = 6), 
  Tank = rep(c("MiniTank1", "MiniTank7"), each = 12), 
  Pathway = rep(c( 
    "map01501 Beta-lactam resistance", 
    "map01502 Vancomycin resistance", 
    "map01503 CAMP resistance" 
  ), each = 4, times = 2), 
  Value = c( 
    # MiniTank1 
    0.475495, 0.426365, 0.429136, 0.422996,  # map01501 
    0.262617, 0.253730, 0.246612, 0.235451,  # map01502 
    0.267469, 0.254314, 0.260860, 0.290568,  # map01503 
 
    # MiniTank7 
    0.471442, 0.432841, 0.423380, 0.421235,  # map01501 
    0.243552, 0.254079, 0.239178, 0.241041,  # map01502 
    0.281686, 0.260926, 0.256503, 0.286153   # map01503 
  ) 
) 
 
df$Timepoint <- factor(df$Timepoint, levels = c("T0", "T2", "T4", "T7")) 
 
p <- ggplot(df, aes(x = Timepoint, y = Value, group = Tank, colour = Tank)) + 
  geom_line(linewidth = 0.9) + 
  geom_point(size = 2) + 
  facet_wrap(~ Pathway, scales = "free_y", ncol = 1) + 
  labs( 
    title = "Temporal trajectories of specific antibiotic resistance pathways", 
    x = "Timepoint", 
    y = "Relative abundance (%)" 
  ) + 
  theme_minimal(base_size = 12) + 
  theme( 
    strip.text = element_text(face = "bold"), 
    panel.grid.minor = element_blank(), 
    legend.position = "top" 
  ) 
 
ggsave("KEGG_specific_AMR_pathways.png", plot = p, width = 8, height = 10, dpi = 300)
