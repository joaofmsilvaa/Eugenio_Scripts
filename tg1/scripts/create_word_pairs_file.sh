#!/bin/bash

corpus_file="../corpus_txt/corpus_clean.txt"
output_file="../corpus_txt/words_dict/words_pairs.txt"

declare -A word_pairs

while read -r line; do
    words=($line)
    for (( i=0; i<${#words[@]}-1; i++ )); do
        pair="${words[i]} ${words[i+1]}"
        if [[ -n "${word_pairs[$pair]}" ]]; then
            word_pairs[$pair]=$((word_pairs[$pair] + 1))
        else
            word_pairs[$pair]=1
        fi
    done
done < "$corpus_file"

for pair in "${!word_pairs[@]}"; do
    echo "$pair ${word_pairs[$pair]}"
done | sort > "$output_file"

echo "Ficheiro de pares de palavras criado em $output_file"
