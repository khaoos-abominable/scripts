#!/bin/bash
# скрипт перекодирует файл из utf в cp1251 если это необходимо
# использование recode_utf.sh файлы_для_обработки

script=$(basename $0)

tmp_file="/tmp/$$.$script"

function recode_file()
{
    #@ DESCRIPTION:
    #@ Перекодирует файл из utf8 в cp1251
    #@ USAGE: recode_file file_name

    local rfile="$1"
    local encoding=$(file -i "$rfile" | sed 's/.*charset=\(.*\)$/\1/')

    if [ $encoding == 'utf-8' ]; then
        echo recoding "$rfile"
        # убираем bom если есть
        sed 's/\xef\xbb\xbf//g;s/$/\r/g' "$rfile" > "$tmp_file"
        iconv -f utf-8 -t cp1251 $tmp_file > "$rfile"
        if [ $? -ne 0 ]; then
            cp "$tmp_file" "$rfile"
        fi
    fi
}


for obj
do
    if [ -f "$obj" ]; then
        recode_file "$obj"
    elif [ -d "$obj" ]; then
        for file in "$obj"/*
        do
            recode_file "$file"
        done
    fi
done

if [ -f $tmp_file ]; then
    rm $tmp_file
fi
