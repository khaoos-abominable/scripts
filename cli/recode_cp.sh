#!/bin/bash
# скрипт перекодирует файл из cp в utf8 если это необходимо
# использование recode_utf.sh файлы_для_обработки

script=$(basename $0)

tmp_file="/tmp/$$.$script"

function recode_file()
{
  #@ DESCRIPTION:
  #@ Перекодирует файл из cp1251 в utf8
  #@ USAGE: recode_file file_name

  local rfile="$1"
  local encoding=$(file -i "$rfile" | sed 's/.*charset=\(.*\)$/\1/')

  if [ $encoding == 'iso-8859-1' ] || [ $encoding == 'us-ascii' ]; then
    echo recoding "$rfile"
    cp "$rfile" "$tmp_file"
    iconv -f cp1251 -t utf-8  "$tmp_file" > "$rfile"
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
