#!/bin/bash

# Specificați calea către fișierul CSV
fisier_csv="data.csv"

# Citiți numele și prenumele pentru a căuta înregistrări
read -p "Introduceți numele: " nume
read -p "Introduceți prenumele: " prenume

# Găsiți înregistrările cu același nume și prenume
inregistrari=$(awk -F"," -v nume="$nume" -v prenume="$prenume" '$2 == nume && $3 == prenume' "$fisier_csv")

# Verificați dacă există înregistrări
if [[ -z $inregistrari ]]; then
    echo "Nu există înregistrări cu numele '$nume' și prenumele '$prenume'."
    exit 1
fi

# Afișați înregistrările în formă de tabel CSV
echo "ID,nume,prenume,email,telefon,varsta,oras_plecare,oras_destinatie,data_zbor,ora_zbor,ora_destinatie,pret_platit,clasa"
echo "$inregistrari"
