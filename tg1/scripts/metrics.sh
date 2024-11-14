#!/bin/bash

FILEPATH="../corpus/deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_FILE="../corpus_info/corpus_info.txt"

echo "O dicionário de palavras vai ser criado em $OUTPUT_FILE"
exec > "$OUTPUT_FILE" 2>&1

# Count and display the total number of characters (excluding newlines).
echo -n "Characters:	"; tr -d '\n' < $FILEPATH | wc -m | cut -d' ' -f1

# Count and display the number of empty lines.
echo -n "Empty lines:	"; grep -v "." $FILEPATH | wc -l | cut -d' ' -f1

# Count total words and unique words.
totalWords=$(tr -s " " '\n' < $FILEPATH | wc -l | cut -d' ' -f1)
uniqueWords=$(tr -s " " '\n' < $FILEPATH | sort -u | wc -l | cut -d' ' -f1)

# Display the total and unique word counts.
echo "Words:	$totalWords"
echo "Unique words:	$uniqueWords"

# Calculate and display the ratio of total words to unique words.
wordsQuotient=$(echo "scale=2; $totalWords/$uniqueWords" | bc)
echo "Quotient (total words / unique words):	$wordsQuotient"

# Count total phrases and unique phrases, splitting text by sentence-ending punctuation.
totalPhrases=$(tr -s '!.?' '\n' < $FILEPATH | wc -l | cut -d' ' -f1)
uniquePhrases=$(tr -s '!.?' '\n' < $FILEPATH | sort -u | wc -l | cut -d' ' -f1)

# Display the total and unique phrase counts.
echo "Phrases:	$totalPhrases"
echo "Unique phrases:	$uniquePhrases"

# Calculate and display the ratio of total phrases to unique phrases.
phrasesQuotient=$(echo "scale=2; $totalPhrases/$uniquePhrases" | bc)
echo "Quotient (total phrases / unique phrases):	$phrasesQuotient"
