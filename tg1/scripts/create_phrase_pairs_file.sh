#!/bin/bash

CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"              
OUTPUT_FILE="../sentences_dict/sentences_pairs.txt"

# Extract lines from "$CORPUS_FILE" that start with a number and a tab, capturing up to the first punctuation mark.
grep -oP '^\d+\t[^.!?]*[.!?]' "$CORPUS_FILE" |

# Replace spaces with vertical bars (|) for easier parsing.
sed 's/ /|/g' |

# Extract the second column (phrases) and save it to a temporary file.
awk '{print $2}' > /tmp/frases_tmp.txt

# Pair each line with the next line in the file, separated by '|'.
paste -d'|' /tmp/frases_tmp.txt <(tail -n +2 /tmp/frases_tmp.txt) |

# Sort and count unique pairs.
sort | uniq -c |

# Format the output with count and phrase pair, saving to "$OUTPUT_FILE".
awk '{print $1 "\t" $2}' > "$OUTPUT_FILE"

rm /tmp/frases_tmp.txt

echo "Dictionary created in $OUTPUT_FILE"

