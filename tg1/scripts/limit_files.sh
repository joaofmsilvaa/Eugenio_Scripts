#!/bin/bash

INPUT_FILE="$1"

DIR_NAME=$(dirname "$INPUT_FILE")
BASE_NAME=$(basename "$INPUT_FILE" .txt)
OUTPUT_FILE="${DIR_NAME}/${BASE_NAME}_limited.txt"

> $OUTPUT_FILE

awk -v max_words="$MAX_WORDS" -v max_phrases="$MAX_PHRASES" -v output_file="$OUTPUT_FILE" '
BEGIN {
    word_count = 0
    phrase_count = 0
    max_words=250000
    max_phrases=250000
}

{
    # Counts the ammount of words in the line
    words_in_line = gsub(/[[:alnum:]]+/, "&", $0)
    # Counts the ammount of phrases delimited by ".", "!" or "?"
    phrases_in_line = gsub(/[.!?]/, "&", $0)

    # Checks if the sum of the current ammount of words with the words of the current line surpass the limit
    # Also checks if the current ammount of phrases with the phrases in the line surpass the limit and if so closes the awk command
    if ((word_count + words_in_line) > max_words || (phrase_count + phrases_in_line) > max_phrases) {
        exit
    }
    
    # Adds the ammount of words/phrases in the current line to the totals
    word_count += words_in_line
    phrase_count += phrases_in_line
	
    print word_count $0 >> output_file
}
' "$INPUT_FILE"
