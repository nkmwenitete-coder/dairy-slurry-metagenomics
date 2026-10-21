#!/usr/bin/env bash
# Examples from dissertation appendix; run only with relevant data and tools installed.
mkdir -p fastqc_output trimmed_reads
fastqc ERR8106110_1.fastq.gz ERR8106110_2.fastq.gz -o fastqc_output
fastp -w 3 -i ERR8106110_1.fastq.gz -I ERR8106110_2.fastq.gz \
  -o trimmed_reads/ERR8106110_R1_trimmed.fastq.gz \
  -O trimmed_reads/ERR8106110_R2_trimmed.fastq.gz \
  -h trimmed_reads/ERR8106110_fastp.html \
  -j trimmed_reads/ERR8106110_fastp.json
prodigal -i MiniTank1_T0_contigs.fasta -a MiniTank1_T0_genes.faa \
  -d MiniTank1_T0_genes.ffn -o MiniTank1_T0_genes.gff -p meta
