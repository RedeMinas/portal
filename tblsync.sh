#!/bin/bash

echo "sync programas"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=0&format=tsv" > /tmp/tbl_pgm.txt

iconv -t ISO-8859-1 /tmp/tbl_pgm.txt > tbl_pgm.txt
rm /tmp/tbl_pgm.txt

echo "sync agenda"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=2032904106&format=tsv" > /tmp/tbl_agenda.txt

iconv -t ISO-8859-1 /tmp/tbl_agenda.txt > tbl_agenda.txt
rm /tmp/tbl_agenda.txt

echo "sync harmonia repertorio"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1716549510&format=tsv" > /tmp/tbl_harmoniarepertorio.txt

iconv -t ISO-8859-1 /tmp/tbl_harmoniarepertorio.txt > tbl_harmoniarepertorio.txt
rm /tmp/tbl_harmoniarepertorio.txt

echo "sync mulheresdelei"

curl  "https://docs.google.com/spreadsheets/d/1oN93tyir9MtQ_ee_ZLALS3tYZqYXKddw658pm0nsCAA/export?gid=0&format=tsv" > /tmp/tbl_mulherese.txt

iconv -t ISO-8859-1 /tmp/tbl_mulherese.txt > tbl_mulherese.txt
rm /tmp/tbl_mulherese.txt
