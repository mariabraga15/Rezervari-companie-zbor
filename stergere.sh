#!/bin/bash

# Functie pt afisarea mesajului de eroare
error(){
  echo "Eroare: $1" >&2
  exit 1
}

# Verifica daca argumentul ID-ului inregistrarii este furnizat
if [ $# -lt 2 ]; then
  error "Utilizare: ./stergere.sh <fisier.csv> <id_inregistrare>"
fi

# Extrage argumentele
csv_file="$1"
record_id="$2"

# Verifica daca fisierul CSV exista
if [ ! -f "$csv_file" ]; then
  error "Fisierul CSV '$csv_file' nu exista."
fi

# Verifica daca ID-ul inregistrarii exista in fisierul CSV
grep -q "^$record_id," "$csv_file" || error "ID-ul inregistrarii '$record_id' nu exista."

# Creeaza un fisier temporar
temp_file=$(mktemp)

#copiaza toate inregistrarile ,cu exceptia celei cu ID-ul specificat, in fisierul temporar
grep -v "^$record_id," "$csv_file" > "$temp_file"

# suprascrie fisierul CSV cu continutul fisierului temporar
mv "$temp_file" "$csv_file"
echo "Se sterge inregistrarea..."
sleep 3
echo "Inregistrarea cu ID_ul '$record_id' a fost stearsa cu succes!"