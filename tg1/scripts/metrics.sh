#!/bin/bash

exec > ../corpus_info/corpus_info.txt 2>&1

FILEPATH="../deu_mixed-typical_2011_300K-sentences.txt"

echo -n "Characters:	"; tr -d '\n' < $FILEPATH | wc -m | cut -d' ' -f1;
echo -n "Empty lines:	"; grep -v "." $FILEPATH | wc -l |cut -d' ' -f1;

totalWords=$(tr -s " " '\n' < $FILEPATH | wc -l | cut -d' ' -f1);
uniqueWords=$(tr -s " " '\n' < $FILEPATH | sort -u | wc -l | cut -d' ' -f1);

echo "Words:	$totalWords"; 
echo "Unique words:	$uniqueWords";

wordsQuotient=$(echo "scale=2; $totalWords/$uniqueWords" | bc);

echo "Quotient (total words / unique words):	$wordsQuotient";

totalPhrases=$(tr -s '!.?' '\n' < $FILEPATH | wc -l | cut -d' ' -f1);
uniquePhrases=$(tr -s '!.?' '\n' < $FILEPATH | sort -u | wc -l | cut -d' ' -f1);

echo "Phrases:	$totalPhrases";
echo "Unique phrases:	$uniquePhrases";

phrasesQuotient=$(echo "scale=2; $totalPhrases/$uniquePhrases" | bc);

echo "Quotient (total phrases / unique phrases):	$phrasesQuotient";
