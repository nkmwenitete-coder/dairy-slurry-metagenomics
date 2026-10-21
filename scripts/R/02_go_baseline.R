# Extracted from dissertation code appendix; not independently executed or validated.
library(ggplot2) 
df <- data.frame( 
GO = c( 
"(GO:0050896) Response to stimulus", 
"(GO:0016020) Membrane", 
"(GO:0044425) Membrane part", 
"(GO:0006412) Translation", 
"(GO:0010467) Gene expression regulation", 
"(GO:0010467) Biosynthetic process" 
), 
Diff = c( -0.060, -0.042, -0.030, 
0.048, 
0.036, 
0.028 
) 
) 
df$Group <- ifelse(df$Diff > 0, 
"Higher in MiniTank1_T0", 
"Higher in MiniTank7_T0") 
ggplot(df, aes(x=reorder(GO, Diff), y=Diff, fill=Group)) + 
geom_col(width=0.75) + 
coord_flip() + 
scale_fill_manual(values=c( 
"Higher in MiniTank1_T0"="#1f78b4", 
"Higher in MiniTank7_T0"="#e31a1c" 
)) + 
labs( 
title="Selected lower-abundance GO term differences at baseline (T0)", 
x="GO term", 
y="Difference in relative abundance (%)\n(MiniTank1_T0 - MiniTank7_T0)" 
) + 
theme_minimal(base_size=12)
