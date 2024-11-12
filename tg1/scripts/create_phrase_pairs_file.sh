#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"              
OUTPUT_FILE="../sentences_dict/sentences_pairs.txt"

grep -oP '^\d+\t[^.!?]*[.!?]' "$CORPUS_FILE" | # Extracts phrases that start with a number and a tab
sort |                                         # Sorts the phrases alphabetically
sed 's/ /|/g' |                                # Replaces spaces with vertical bars.
awk '{print $2}' |                             # Extracts the phrase.
awk 'NR==1 {prev=$0; next} {print prev "|" $0; prev=$0}' | # Joins the first phrase of the pair with the second.
sort |                                         # Sorts the pairs.
uniq -c |                                      # Counts the occurrence of each phrase.
awk '{print $2 "\t" $1}' > "$OUTPUT_FILE"      # Formats and saves the result at "$OUTPUT_FILE".

./limit_files.sh $OUTPUT_FILE

echo "O Dicionário foi criado em $OUTPUT_FILE"

