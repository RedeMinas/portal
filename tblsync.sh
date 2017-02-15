#!/bin/bash

echo "sync programas"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=0&format=tsv" > /tmp/tbl_pgm.txt

iconv -t ISO-8859-1 /tmp/tbl_pgm.txt > tbl_pgm.txt
rm /tmp/tbl_pgm.txt

echo "sync agenda evt"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=2032904106&format=tsv" > /tmp/tbl_agendaevt.txt

iconv -t ISO-8859-1 /tmp/tbl_agendaevt.txt > tbl_agendaevt.txt
rm /tmp/tbl_agendaevt.txt

echo "sync agenda ccs"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1140740711&format=tsv" > /tmp/tbl_agendacc.txt

iconv -t ISO-8859-1 /tmp/tbl_agendacc.txt > tbl_agendacc.txt
rm /tmp/tbl_agendacc.txt



echo "sync harmonia repertorio"

curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1716549510&format=tsv" > /tmp/tbl_harmoniarep.txt

iconv -t ISO-8859-1 /tmp/tbl_harmoniarep.txt > tbl_harmoniarep.txt
rm /tmp/tbl_harmoniarep.txt

echo "sync mulheresdelei"

#original
#curl  "https://docs.google.com/spreadsheets/d/1oN93tyir9MtQ_ee_ZLALS3tYZqYXKddw658pm0nsCAA/export?gid=0&format=tsv" > /tmp/tbl_mulherese.txt
curl "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1045078955&format=tsv" > /tmp/tbl_mulherese.txt


iconv -t ISO-8859-1 /tmp/tbl_mulherese.txt > tbl_mulherese.txt
rm /tmp/tbl_mulherese.txt
