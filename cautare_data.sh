#!/bin/bash

read -p "Introduceți data zborului (în formatul YYYY/MM/DD): " data_cautata
echo "Cautam inregistrari cu data pe care mi-ati dat-o..."
sleep 3

zboruri_gasite=false

while IFS=',' read -r ID nume prenume email telefon varsta oras_plecare oras_destinatie data_zbor ora_zbor ora_destinatie pret_platit clasa; do
    if [[ "$data_zbor" = "$data_cautata" ]]; then
        zboruri_gasite=true
        echo "$ID $nume $prenume  $email  $telefon  $varsta $oras_plecare $oras_destinatie $data_zbor  $ora_zbor $ora_destinatie $pret_platit $clasa"
    fi
done < <(tail -n +2 data.csv)

# Afișează un mesaj de eroare dacă nu s-au găsit zboruri
if [[ "$zboruri_gasite" = false ]]; then
    echo "Nu s-au găsit înregistrări pentru data introdusă."
fi
