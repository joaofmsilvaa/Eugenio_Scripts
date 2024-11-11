#!/bin/bash

# Caminho para o arquivo de palavras
words_file="../words_dict/words.txt"
# Caminho para o arquivo de saída
pairs_file="../words_dict/words_pairs.txt"

# Verifica se o arquivo de palavras existe
if [[ ! -f "$words_file" ]]; then
  echo "Erro: O arquivo de palavras '$words_file' não existe."
  exit 1
fi

# Usando AWK para criar os pares de palavras sem contagem de ocorrências
awk '{
  if (prev_word != "") {
    print prev_word, $0  # Imprime o par de palavras
  }
  prev_word = $0
}' "$words_file" | awk '{print $2, $3}' > "$pairs_file"

echo "Pares de palavras criados em '$pairs_file'."
