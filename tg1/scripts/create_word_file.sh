#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_DIR="../words_dict"
OUTPUT_FILE="$OUTPUT_DIR/words.txt"


tr -c '[:alpha:]' '[\n*]' < "$CORPUS_FILE" |  
tr '[:upper:]' '[:lower:]' |                
awk 'NF' |                                  
sort |                                      
uniq -c |                                   
sort -k2,2 > "$OUTPUT_FILE"                 

echo "Dicionário de palavras criado em $OUTPUT_FILE"
