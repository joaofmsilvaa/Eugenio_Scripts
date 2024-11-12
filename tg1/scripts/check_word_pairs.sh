#!/bin/bash

# Caminhos para os arquivos
WORDS_FILE="../words_dict/words.txt"
PAIRS_FILE="../words_dict/words_pairs.txt"

> '../words_dict/words_pairs_check.txt'

# Verifica se os arquivos existem
if [[ ! -f "$WORDS_FILE" ]]; then
    echo "Arquivo words.txt não encontrado!"
    exit 1
fi

if [[ ! -f "$PAIRS_FILE" ]]; then
    echo "Arquivo words_pairs_check.txt não encontrado!"
    exit 1
fi

echo "Arquivos encontrados. Iniciando a verificação..."

# Para cada par de palavras no arquivo words_pairs_check.txt
while IFS="|" read -r word1 word2; do
    # Remover espaços extras
    word1=$(echo "$word1" | xargs)
    word2=$(echo "$word2" | xargs)

    # Remover números antes das palavras no words.txt (caso existam)
    word1_clean=$(echo "$word1" | awk '{print $NF}')
    word2_clean=$(echo "$word2" | awk '{print $NF}')

    # Verifica se a palavra word1_clean existe em words.txt
    if grep -qw "$word1_clean" "$WORDS_FILE"; then
        echo "Palavra encontrada: $word1"
        >> '../words_dict/words_pairs_check.txt'
    fi

    # Verifica se a palavra word2_clean existe em words.txt
    if grep -qw "$word2_clean" "$WORDS_FILE"; then
        echo "Palavra encontrada: $word2"
        >> '../words_dict/words_pairs_check.txt'
    fi

done < "$PAIRS_FILE"

echo "Verificação concluída."
