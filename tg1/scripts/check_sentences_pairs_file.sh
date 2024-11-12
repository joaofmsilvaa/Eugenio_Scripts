#!/bin/bash

# Caminhos para os arquivos
SENTENCES_FILE="../sentences_dict/sentences.txt"
PAIRS_FILE="../sentences_dict/sentences_pairs.txt"
OUTPUT_FILE="../sentences_dict/sentences_pairs_check.txt"

# Limpa o arquivo de saída
> "$OUTPUT_FILE"

# Verifica se os arquivos existem
if [[ ! -f "$SENTENCES_FILE" ]]; then
    echo "Arquivo sentences.txt não encontrado!"
    exit 1
fi

if [[ ! -f "$PAIRS_FILE" ]]; then
    echo "Arquivo sentences_pairs.txt não encontrado!"
    exit 1
fi

# Cria o dicionário de frases a partir do sentences.txt usando awk
awk '
    # Ao carregar o sentences.txt, cria um dicionário
    FNR==NR {
        #gsub(/^ +| +$/, "", $0);  # Remove espaços nas extremidades
        gsub(/\t[0-9]+$/, "", $0);
        gsub(/\|/, " ", $0);
        dict[$0] = 1;
        next
 }
    # Para cada linha do pairs.txt, processa as frases
    {
        match($0,/[.!?]/)
        sentence1 = substr($0, 1, RSTART);
        sentence2 = substr($0, RSTART +1);
        
        
        # Substitui "|" por espaços para reconstruir as frases
        gsub(/\|/, " ", sentence1);
        gsub(/\|/, " ", sentence2);


        # Limpa espaços extras nas extremidades
        gsub(/^ +| +$/, "", sentence1);
        gsub(/^ +| +$/, "", sentence2);
        gsub(/\t[0-9]+$/, "",sentence2);
        
        
        # Verifica se as frases estão no dicionário e escreve no arquivo de saída
        if (sentence1 in dict) {
            print "Frase encontrada: " sentence1 >> "'$OUTPUT_FILE'";
        } else {
            print "Frase não encontrada no dicionário: " sentence1 >> "'$OUTPUT_FILE'";
        }

        if (sentence2 in dict) {
            print "Frase encontrada: " sentence2 >> "'$OUTPUT_FILE'";
        } else {
            print "Frase não encontrada no dicionário: " sentence2 >> "'$OUTPUT_FILE'";
        }
    }
' "$SENTENCES_FILE" "$PAIRS_FILE"

# Chama o script limit_files.sh
./limit_files.sh "$OUTPUT_FILE"

echo "O Dicionário foi criado em $OUTPUT_FILE"
