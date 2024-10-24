
CORPUS_FILE="../deu_mixed-typical_2011_300K-sentences.txt"
OUTPUT_FILE="../sentences_dict/sentences_pairs.txt"

# cat - read the entire file
# tr - replace spaces with the "|" sign
# awk - filter the output to remove the line number
# sed - concatenate the odd line ($) with the even line (N)
# sort - sort the output by alphabethic order
# uniq -c - count the occurrences of each line
cat $CORPUS_FILE | tr ' ' '|' | awk '{print $2}' | uniq -c | sed '$!N;s/\n//' | sed 's/  */ /g'| sort > $OUTPUT_FILE

