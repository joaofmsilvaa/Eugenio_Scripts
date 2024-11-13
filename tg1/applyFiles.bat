@echo off
REM "The following command adds support to UTF-8 characters and allows the shell to recognize the 'é' in Eugénio"
chcp 65001

set "SOURCE_DIR=C:\Users\35193\OneDrive\Ambiente de Trabalho\eug"
set "FILE1=words.txt"
set "FILE2=words_pairs.txt"
set "FILE3=sentences.txt"
set "FILE4=sentences_pairs.txt"

set "DEST_FILE1=geral.pal"
set "DEST_FILE2=geral.par"
set "DEST_FILE3=geral.frs"
set "DEST_FILE4=geral.paf"

if exist "C:\Program Files\Eugénio" (
    set "TARGET_DIR=C:\Program Files\Eugénio"
) else (
    if exist "C:\Program Files (x86)\Eugénio" (
        set "TARGET_DIR=C:\Program Files (x86)\Eugénio"
    ) else (
        echo ERRO: O Eugénio não foi instalado.
        pause
        exit /b
    )
)

echo Copiando arquivos para %TARGET_DIR%...
copy "%SOURCE_DIR%\%FILE1%" "%TARGET_DIR%\%DEST_FILE1%"
copy "%SOURCE_DIR%\%FILE2%" "%TARGET_DIR%\%DEST_FILE2%"
copy "%SOURCE_DIR%\%FILE3%" "%TARGET_DIR%\%DEST_FILE3%"
copy "%SOURCE_DIR%\%FILE4%" "%TARGET_DIR%\%DEST_FILE4%"

echo Ficheiros copiados com sucesso para %TARGET_DIR%.
