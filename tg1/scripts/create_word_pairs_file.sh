#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_FILE="../words_dict/words_pairs.txt"

tr -c '[:alpha:]' '[\n*]' < "$CORPUS_FILE" |  # Replaces non-letter characters with newlines
tr '[:upper:]' '[:lower:]' |                   # Converts all uppercase letters to lowercase
awk 'NF' |                                      # Removes empty lines.
awk 'NR==1 {prev=$0; next} {print prev "|" $0; prev=$0}' | # Joins the first word of the pair with the second.
sort |                                          # Sorts the pairs alphabetically.
uniq -c |                                       # Counts the occurrence.
sort -k2,2 |                                     # Sorts the lines by the pair.
awk '{print $1 "\t" $2}' > "$OUTPUT_FILE"

# Execute the limit_files.sh script (optional step)
./limit_files.sh $OUTPUT_FILE

# Notificação de conclusão.
echo "O Dicionário foi criado em $OUTPUT_FILE"
