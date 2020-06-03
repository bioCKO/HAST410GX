#!/bin/bash
# Uasge:
#   sh barcode_fastq_gz_2_10xg_raw.sh barcoded.fastq \
#                                     sample_S1_L001_R1_001.fastq \
#                                     sample_S2_L001_R2_001.fastq
#
# Paramters:
#   $1 refer to reads generated by longranger basic command
#   $2 is read1 in 10x genomics raw reads format
#   $3 is read2 in 10x genomics raw reads format
#
# Warning :
#   this scrip always append into $2 and $3 if thoes file already exist.

awk   -F "BX:Z:"  -v read1=$2 -v read2=$3  'BEGIN{i=0;}{i+=1;if(i==9)i=1; if(i==1||i==5){if($2!="") barcode=substr($2,1,16);else barcode="NNNNNNNNNNNNNNNN"}  if(i==1) printf("%s 1:N:0:0\n", $1) > read1 ; else if(i==2) printf("%sNNNNNNN%s\n",barcode,$1) >read1;else if (i%8==3) print $1 > read1 ; else if (i%8==4) printf("KKKKKKKKKKKKKKKKKKKKKKK%s\n",$1) >read1; else if (i%8==5) printf("%s 3:N:0:0\n", $1) >read2; else print $1 >read2; }'   $1

wc -l $2 >>"trasnfer.log"
wc -l $3 >>"trasnfer.log"

