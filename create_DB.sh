#!/bin/bash

csv_file="data.csv"

# Verifică dacă fișierul CSV există
if [ -f "$csv_file" ]; then
  echo "Fișierul CSV există deja."
else
 echo "ID,nume,prenume,email,telefon,varsta,oras_plecare,oras_destinatie,data_zbor,ora_zbor,ora_destinatie,pret_platit,clasa" > "$csv_file"

echo "Structura de date CSV a fost creată cu succes în fișierul $csv_file."
fi
