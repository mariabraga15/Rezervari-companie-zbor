#!/bin/bash

# Functie pt afisarea mesajului de eroare
error(){
  echo "Eroare: $1" >&2
  exit 1
}

# Verifica daca argumentul fisierului CSV este furnizat
if [ $# -lt 1 ]; then
  error "Utilizare: ./sortatre_plecare_destinatie.sh <fisier.csv>"
fi

# Extrage argumentul fisierului CSV
csv_file="$1"

# Verifica daca fisierul CSV exista
if [ ! -f "$csv_file" ]; then
  error "Fisierul CSV '$csv_file' nu exista."
fi

#Sorteaza inregistrarile dupa plecare si destinatie
sorted_file="sortare_p_d_data.csv"
tail -n +2 "$csv_file" | sort -t ',' -k 7,7 -k 8,8 | (echo "$(head -n 1 "$csv_file")"; cat) | column -t -s ',' > "$sorted_file"

# Afiseaza in consola


echo "Inregistrarile au fost sortate dupa orasul plecare si orasul destinatie cu succes!"
./tabel.sh "$sorted_file"
