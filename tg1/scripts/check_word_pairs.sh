#!/bin/bash

# Caminhos para os arquivos
WORDS_FILE="../words_dict/words.txt"
PAIRS_FILE="../words_dict/words_pairs.txt"
OUTPUT_FILE="../words_dict/words_pairs_check.txt"

# Limpa o arquivo de saída
> "$OUTPUT_FILE"

# Verifica se os arquivos existem
if [[ ! -f "$WORDS_FILE" ]]; then
    echo "Arquivo words.txt não encontrado!"
    exit 1
fi

if [[ ! -f "$PAIRS_FILE" ]]; then
    echo "Arquivo words_pairs.txt não encontrado!"
    exit 1
fi

# Processa cada par de palavras no arquivo words_pairs.txt usando awk
awk -F'|' -v output="$OUTPUT_FILE" -v words_file="$WORDS_FILE" '
BEGIN {
    # Lê o arquivo words.txt para dentro de um dicionário
    while ((getline word < words_file) > 0) {
        gsub(/^ +| +$/, "", word);  # Remove espaços nas extremidades
        dict[word] = 1;
        # Debug: confirma que a palavra foi carregada
        
    }
    close(words_file);
}
{
    # Limpa os espaços nas palavras do par
    word1 = $1;
    word2 = $2;
    gsub(/^ +| +$/, "", word1);
    gsub(/^ +| +$/, "", word2);
    
    # Debug: exibe as palavras lidas do par
    print "Processando par:", word1, "|", word2 >> output;

    # Verifica a presença das palavras e escreve no arquivo de saída
    if (word1 in dict) {
        print "Palavra encontrada:", word1 >> output;
    } else {
        # Debug: indica que a palavra1 não foi encontrada
        print "Palavra não encontrada no dicionário:", word1 >> output;
    }
    if (word2 in dict) {
        print "Palavra encontrada:", word2 >> output;
    } else {
        # Debug: indica que a palavra2 não foi encontrada
        print "Palavra não encontrada no dicionário:", word2 >> output;
    }
}
' "$PAIRS_FILE"

# Chama o script limit_files.sh
./limit_files.sh "$OUTPUT_FILE"

echo "O Dicionário foi criado em $OUTPUT_FILE"
