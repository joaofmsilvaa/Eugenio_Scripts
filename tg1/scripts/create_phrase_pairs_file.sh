#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"              
OUTPUT_FILE="../sentences_dict/sentences_pairs.txt"

awk -F'\t' '{print $2}' "$CORPUS_FILE" |
sed 's/ /|/g' | sort -u |
tee >(tail -n +2) | paste -d "" - - |
sort | uniq -c |
awk '{print $1 " " $2}' > "$OUTPUT_FILE"
