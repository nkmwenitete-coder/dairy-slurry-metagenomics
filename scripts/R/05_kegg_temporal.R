# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
 
df <- data.frame( 
  Timepoint = rep(c("T0", "T2", "T4", "T7"), times = 12), 
  Tank = rep(c("MiniTank1", "MiniTank7"), each = 24), 
  Pathway = rep(c( 
    "map02024 Quorum sensing", 
    "map02030 Bacterial chemotaxis", 
    "map02020 Two-component system", 
    "map00230 Purine metabolism", 
    "map01230 Biosynthesis of amino acids", 
    "map00500 Starch and sucrose metabolism" 
  ), each = 4, times = 2), 
  Value = c( 
    # MiniTank1 
    1.27423, 1.32477, 1.38600, 1.41830,   # map02024 
    0.154758, 0.154859, 0.216973, 0.284140, # map02030 
    1.06037, 1.05592, 1.18045, 1.36217,   # map02020 
    2.58908, 2.52621, 2.43534, 2.34629,   # map00230 
    3.19586, 3.17224, 3.18666, 3.11989,   # map01230 
    1.06576, 0.96555, 0.915266, 0.821451, # map00500 
 
    # MiniTank7 
    1.23918, 1.31839, 1.34094, 1.38350,   # map02024 
    0.227259, 0.170237, 0.210228, 0.259695, # map02030 
    1.19606, 1.08633, 1.16949, 1.28902,   # map02020 
    2.55203, 2.51273, 2.45111, 2.41257,   # map00230 
    3.14300, 3.19100, 3.18409, 3.12453,   # map01230 
    0.963602, 0.963488, 0.927986, 0.874766 # map00500 
  ) 
) 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
df$Timepoint <- factor(df$Timepoint, levels = c("T0", "T2", "T4", "T7")) 
 
p <- ggplot(df, aes(x = Timepoint, y = Value, group = Tank, colour = Tank)) + 
  geom_line(linewidth = 0.9) + 
  geom_point(size = 2) + 
  facet_wrap(~ Pathway, scales = "free_y", ncol = 2) + 
  labs( 
    title = "Temporal trajectories of selected KEGG pathways", 
    x = "Timepoint", 
    y = "Relative abundance (%)" 
  ) + 
  theme_minimal(base_size = 12) + 
  theme( 
    strip.text = element_text(face = "bold"), 
    panel.grid.minor = element_blank(), 
    legend.position = "top" 
  ) 
 
ggsave("KEGG_temporal_trends_selected.png", plot = p, width = 10, height = 12, dpi = 300)
