#!/usr/bin/env bash
# Commands adapted from dissertation appendix; example for MiniTank1_T0.
# Review eggNOG column schema before executing.
total=$(grep -v "^#" MiniTank1_T0.emapper.tabular | wc -l) 
go_count=$(grep -v "^#" MiniTank1_T0.emapper.tabular | awk -F'\t' '$10 != "-" {count++} END {print count+0}') 
kegg_path_count=$(grep -v "^#" MiniTank1_T0.emapper.tabular | awk -F'\t' '$13 != "-" {count++} END {print count+0}') 
unannotated=$(grep -v "^#" MiniTank1_T0.emapper.tabular | awk -F'\t' '$10 == "-" && $13 == "-" {count++} END {print count+0}') 
echo "Total genes: $total" 
echo "GO annotated genes: $go_count" 
echo "KEGG pathway annotated genes: $kegg_path_count" 
echo "Unannotated genes: $unannotated" 
echo "Percent GO annotated: $(echo "scale=2; ($go_count/$total)*100" | bc)%" 
echo "Percent KEGG pathway annotated: $(echo "scale=2; ($kegg_path_count/$total)*100" | bc)%" 
echo "Percent unannotated: $(echo "scale=2; ($unannotated/$total)*100" | bc)%" 
# 2) Code to create the clean 5-column annotation file 
grep -v "^#" MiniTank1_T0.emapper.tabular | cut -f1,8,10,12,13 > MiniTank1_T0_clean.tsv 
# 3) Check the clean file has exactly 5 columns 
awk -F'\t' '{print NF}' MiniTank1_T0_clean.tsv | sort | uniq 
# 4) GO term counting code 
cut -f3 MiniTank1_T0_clean.tsv | grep -v "^-$" | tr ',' '\n' | sort | uniq -c | sort -nr > GO_counts.txt 
# 5) KEGG pathway counting code 
cut -f5 MiniTank1_T0_clean.tsv | grep -v "^-$" | tr ',' '\n' | sort | uniq -c | sort -nr > KEGG_pathway_counts.txt 
# 6) Merge KO and Map Ids 
sed 's/^ *\([0-9]*\) ko/\1 map/' KEGG_pathway_counts.txt > KEGG_fixed.txt 
awk '{counts[$2]+=$1} END {for (k in counts) print counts[k], k}' KEGG_fixed.txt | sort -nr > KEGG_merged.txt 
# 7) Merge vanity check  
head KEGG_merged.txt 
grep "ko" KEGG_merged.txt 
wc -l KEGG_merged.txt 
# 8) Go Term filtering 
grep -v -E "GO:0008150|GO:0003674|GO:0005575" GO_counts.txt > GO_counts_filtered.txt 
head -10 GO_counts_filtered.txt > GO_top10.txt 
# 9) Normalisation to enable comparison 
#GO 
total=$(awk '{sum += $1} END {print sum}' GO_counts_filtered.txt) 
awk -v total=$total '{print ($1/total)*100, $2}' GO_counts_filtered.txt > GO_norm.txt 
head -10 GO_norm.txt > GO_top10_norm.txt 
#KEGG 
total=$(awk '{sum += $1} END {print sum}' KEGG_merged.txt) 
awk -v total=$total '{print ($1/total)*100, $2}' KEGG_merged.txt > KEGG_norm.txt 
head -10 KEGG_norm.txt > KEGG_top10_norm.txt 

