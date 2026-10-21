# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
df <- data.frame( 
Pathway = c( 
"(map02020) Two-component system", 
"(map02010) ABC transporters", 
"(map00190) Oxidative phosphorylation", 
"(map00630) Glyoxylate metabolism", 
"(map03010) Ribosome", 
"(map02024) Quorum sensing", 
"(map03440) DNA repair proteins", 
"(map00500) Starch and sucrose metabolism" 
), 
Diff = c( -0.135, -0.058, -0.035, -0.021, 
0.022, 
0.036, 
0.046, 
0.102 
) 
) 
df$Group <- ifelse(df$Diff > 0, 
"Higher in MiniTank1_T0", 
"Higher in MiniTank7_T0") 
ggplot(df, aes(x=reorder(Pathway, Diff), y=Diff, fill=Group)) + 
geom_col(width=0.75) + 
coord_flip() + 
scale_fill_manual(values=c( 
"Higher in MiniTank1_T0"="#1f78b4", 
"Higher in MiniTank7_T0"="#e31a1c" 
)) + 
labs( 
title="Selected lower-abundance KEGG pathway differences at baseline (T0)", 
x="KEGG pathway", 
y="Difference in relative abundance (%)\n(MiniTank1_T0 - MiniTank7_T0)" 
) + 
theme_minimal(base_size=12)
