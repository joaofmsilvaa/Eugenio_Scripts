#!/bin/bash

# Paths to files
SENTENCES_FILE="../sentences_dict/sentences.txt"
PAIRS_FILE="../sentences_dict/sentences_pairs.txt"
OUTPUT_FILE="../sentences_dict/sentences_pairs_check.txt"

# Clean the output file
> "$OUTPUT_FILE"

# Check if files exist
if [[ ! -f "$SENTENCES_FILE" ]]; then
    echo "Arquivo sentences.txt não encontrado!"
    exit 1
fi

if [[ ! -f "$PAIRS_FILE" ]]; then
    echo "Arquivo sentences_pairs.txt não encontrado!"
    exit 1
fi

# Creates the sentence dictionary from sentences.txt
awk '
    # When loading sentences.txt, it creates a dictionary
    FNR==NR {
        #gsub(/^ +| +$/, "", $0);  # Removes spaces at the ends
        gsub(/\t[0-9]+$/, "", $0);
        gsub(/\|/, " ", $0);
        dict[$0] = 1;
        next
 }
    # For each line of pairs.txt, process the sentences
    {
        match($0,/[.!?]/)
        sentence1 = substr($0, 1, RSTART);
        sentence2 = substr($0, RSTART +1);
        
        
        # Replace "|" with spaces to reconstruct sentences
        gsub(/\|/, " ", sentence1);
        gsub(/\|/, " ", sentence2);


        # Cleans up extra spaces at the ends
        gsub(/^ +| +$/, "", sentence1);
        gsub(/^ +| +$/, "", sentence2);
        gsub(/\t[0-9]+$/, "",sentence2);
        
        
        # Checks if the sentences are in the dictionary and writes to the output file
        if (sentence1 in dict) {
            print "Frase encontrada: " sentence1 >> "'$OUTPUT_FILE'";
        } else {
            print "Frase não encontrada no dicionário: " sentence1 >> "'$OUTPUT_FILE'";
        }

        if (sentence2 in dict) {
            print "Frase encontrada: " sentence2 >> "'$OUTPUT_FILE'";
        } else {
            print "Frase não encontrada no dicionário: " sentence2 >> "'$OUTPUT_FILE'";
        }
    }
' "$SENTENCES_FILE" "$PAIRS_FILE"

# Call the limit_files.sh script
#./limit_files.sh "$OUTPUT_FILE"

echo "O Dicionário foi criado em $OUTPUT_FILE"
