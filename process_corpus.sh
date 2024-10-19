#!/bin/bash

INPUT_FILE="/home/joao_calado/Documents/so/tg1/deu_mixed-typical_2011_300K/deu_mixed-typical_2011_300K-sentences.txt"

OUTPUT_DIR="../corpus_txt"

OUTPUT_FILE="$OUTPUT_DIR/corpus_clean.txt"

mkdir -p "$OUTPUT_DIR"

awk '{$1=""; sub(/^[ \t]+/, ""); print}' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Processamento concluído! O ficheiro limpo está em $OUTPUT_FILE"
