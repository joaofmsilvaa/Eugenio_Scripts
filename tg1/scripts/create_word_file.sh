#!/bin/bash

CORPUS_FILE="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_DIR="../words_dict"
OUTPUT_FILE="$OUTPUT_DIR/words.txt"

tr -c '[:alpha:]' '[\n*]' < "$CORPUS_FILE" | # Replace all non-letter characters with newlines
tr '[:upper:]' '[:lower:]' | # Convert all uppercase characters to lowercase               
awk 'NF' | # Remove empty lines                         
sort | # Sort alphabetically                                 
uniq -c | # Count the occurrence of each word                             
sort -k2,2 | # Sort each line by the word 
sed -e 's/[ \t]*//' | # Remove excessive tabs 
awk '{print $2 "\t" $1}' > "$OUTPUT_FILE"           

./limit_files.sh $OUTPUT_FILE

echo "O Dicionário foi criado em $OUTPUT_FILE"
