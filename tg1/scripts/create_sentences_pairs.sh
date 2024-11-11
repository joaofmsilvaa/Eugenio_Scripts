#!/bin/bash

# Caminho para o arquivo de frases
sentences_file="../sentences_dict/sentences.txt"
# Caminho para o arquivo de saída
pairs_file="../sentences_dict/sentence_pairs.txt"

# Verifica se o arquivo de frases existe
if [[ ! -f "$sentences_file" ]]; then
  echo "Erro: O arquivo de frases '$sentences_file' não existe."
  exit 1
fi

# Limpa o arquivo de pares de frases antes de gerar novos pares
> "$pairs_file"

# Usando AWK para gerar os pares de frases
awk 'NR>1 {print prev_line "|" $0} {prev_line=$0}' "$sentences_file" > "$pairs_file"

echo "Pares de frases criados em '$pairs_file'."
