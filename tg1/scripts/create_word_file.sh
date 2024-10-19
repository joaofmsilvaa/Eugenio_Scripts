#!/bin/bash

CORPUS_FILE="../corpus_txt/corpus_clean.txt"
OUTPUT_DIR="../corpus_txt/words_dict"
OUTPUT_FILE="$OUTPUT_DIR/words.txt"

if [[ ! -f $CORPUS_FILE ]]; then
    echo "O arquivo de corpus não foi encontrado!"
    exit 1
fi

tr -c '[:alpha:]' '[\n*]' < "$CORPUS_FILE" |  
tr '[:upper:]' '[:lower:]' |                
awk 'NF' |                                  
sort |                                      
uniq -c |                                   
sort -k2,2 > "$OUTPUT_FILE"                 

echo "Dicionário de palavras criado em $OUTPUT_FILE"
