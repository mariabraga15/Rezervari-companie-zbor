#!/bin/bash

csv_file="data.csv"
sorted_file="sorted_data.csv"

tail -n +2 "$csv_file" | sort -t ',' -k 2 > "$sorted_file"

echo "Înregistrările au fost sortate după nume în fișierul $sorted_file."
./tabel.sh "$sorted_file"
