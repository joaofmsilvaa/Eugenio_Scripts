
CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_FILE="../sentences_dict/sentences.txt"

cat $CORPUS_FILE | tr ' ' '|' | awk '{print $2}' | sort  | uniq -c > $OUTPUT_FILE

