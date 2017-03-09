#!/bin/bash
par=$1

echo "sync pgm"
curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=0&format=tsv" > /tmp/tbl_pgm.txt


echo "sync agenda evt"
curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=2032904106&format=tsv" > /tmp/tbl_agendaevt.txt

echo "sync agenda cc"
curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1140740711&format=tsv" > /tmp/tbl_agendacc.txt

echo "sync harmonia repertorio"
curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1716549510&format=tsv" > /tmp/tbl_harmoniarep.txt


echo "sync harmonia extra"
curl  "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1982803619&format=tsv" > /tmp/tbl_harmoniaextra.txt

echo "sync mulheresdelei"
#original
#curl  "https://docs.google.com/spreadsheets/d/1oN93tyir9MtQ_ee_ZLALS3tYZqYXKddw658pm0nsCAA/export?gid=0&format=tsv" > /tmp/tbl_mulherese.txt

curl "https://docs.google.com/spreadsheets/d/1JV9f29P7MvIzclLvaein7g7GjdaBCcYiCt6-UpHFfhU/export?gid=1045078955&format=tsv" > /tmp/tbl_mulherese.txt




if [[ -n "$par" ]]
then
    echo "utf-8"
    echo "copying pgm "
    cp /tmp/tbl_pgm.txt  tbl_pgm.txt

    echo "copying agenda evt"
    cp /tmp/tbl_agendaevt.txt tbl_agendaevt.txt

    echo "copying agenda cc"
    cp /tmp/tbl_agendacc.txt  tbl_agendacc.txt

    echo "copying harmonia rep"
    cp /tmp/tbl_harmoniarep.txt  tbl_harmoniarep.txt

    echo "copying harmonia extra"
    cp /tmp/tbl_harmoniaextra.txt  tbl_harmoniaextra.txt

    echo "copying mulheresdelei"
    cp /tmp/tbl_mulherese.txt  tbl_mulherese.txt


else
    echo "converting pgm"
    iconv -t ISO-8859-1 /tmp/tbl_pgm.txt > tbl_pgm.txt

    echo "converting agenda evt"
    iconv -t ISO-8859-1 /tmp/tbl_agendaevt.txt > tbl_agendaevt.txt

    echo "converting agenda cc"
    iconv -t ISO-8859-1 /tmp/tbl_agendacc.txt > tbl_agendacc.txt

    echo "converting harmonia rep"
    iconv -t ISO-8859-1 /tmp/tbl_harmoniarep.txt > tbl_harmoniarep.txt

    echo "converting harmonia extra"
    iconv -t ISO-8859-1 /tmp/tbl_harmoniaextra.txt > tbl_harmoniaextra.txt

    echo "converting mulheresdelei"
    iconv -t ISO-8859-1 /tmp/tbl_mulherese.txt > tbl_mulherese.txt
fi
