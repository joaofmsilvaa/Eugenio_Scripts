#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_FILE="../sentences_dict/sentences.txt"

# Reads the full file, replaces the spaces with "|", prints the phrase,
# sorts it alphabetically and counts the occurrence of each phrase
cat $CORPUS_FILE | tr ' ' '|' | awk '{print $2}' | sort  | uniq -c > $OUTPUT_FILE

echo "Dicionário de palavras criado em $OUTPUT_FILE"
