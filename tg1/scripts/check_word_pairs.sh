#!/bin/bash

# Paths to files
WORDS_FILE="../words_dict/words.txt"
PAIRS_FILE="../words_dict/words_pairs.txt"
OUTPUT_FILE="../words_dict/words_pairs_check.txt"

# Clean the output file
> "$OUTPUT_FILE"

# Check if files exist
if [[ ! -f "$WORDS_FILE" ]]; then
    echo "Arquivo words.txt não encontrado!"
    exit 1
fi

if [[ ! -f "$PAIRS_FILE" ]]; then
    echo "Arquivo words_pairs.txt não encontrado!"
    exit 1
fi

# Process each word pair in the file words_pairs.txt
awk -F'|' -v output="$OUTPUT_FILE" -v words_file="$WORDS_FILE" '
BEGIN {
    #Reads the file words.txt into a dictionary
    while ((getline word < words_file) > 0) {
        gsub(/^ +| +$/, "", word);  # Removes spaces at the ends
        dict[word] = 1;
        
    }
    close(words_file);
}
{
    # Cleans up spaces in pair words
    word1 = $1;
    word2 = $2;
    gsub(/^ +| +$/, "", word1);
    gsub(/^ +| +$/, "", word2);
    
    print "Processando o par:", word1, "|", word2 >> output;

    # Checks for the presence of words and writes to the output file
    if (word1 in dict) {
        print "Palavra encontrada:", word1 >> output;
    } else {
        print "Palavra não encontrada no dicionário:", word1 >> output;
    }
    if (word2 in dict) {
        print "Palavra encontrada:", word2 >> output;
    } else {
        print "Palavra não encontrada no dicionário:", word2 >> output;
    }
}
' "$PAIRS_FILE"

# Call the limit_files.sh script
./limit_files.sh "$OUTPUT_FILE"

echo "O Dicionário foi criado em $OUTPUT_FILE"
