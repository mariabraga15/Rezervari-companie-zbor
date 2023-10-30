#!/bin/bash
awk -F',' '{ print $9, $0 }' data.csv | sort -t' ' -k1,1 -k2,2 | cut -d' ' -f2- > data_sorted.csv
echo "Fisierul a fost sortat in functie de data rezervarii."
./tabel.sh data_sorted.csv | head -n -1
