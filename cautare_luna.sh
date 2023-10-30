#!/bin/bash

declare -A luni=(
    ["ianuarie"]="01"
    ["februarie"]="02"
    ["martie"]="03"
    ["aprilie"]="04"
    ["mai"]="05"
    ["iunie"]="06"
    ["iulie"]="07"
    ["august"]="08"
    ["septembrie"]="09"
    ["octombrie"]="10"
    ["noiembrie"]="11"
    ["decembrie"]="12"
)

read -p "Introduceți numele lunii: " nume_luna
echo "Căutăm înregistrări cu data din luna $nume_luna..."
sleep 3

numar_luna=${luni[$nume_luna]}

if [[ -z "$numar_luna" ]]; then
    echo "Numele lunii introdus nu este valid."
    exit 1
fi

zboruri_gasite=false

while IFS=',' read -r ID nume prenume email telefon varsta oras_plecare oras_destinatie data_zbor ora_zbor ora_destinatie pret_platit clasa; do
    luna=$(echo "$data_zbor" | cut -d '/' -f2)
    if [[ "$luna" == "$numar_luna" ]]; then
        zboruri_gasite=true
        echo "$ID $nume $prenume $email $telefon $varsta $oras_plecare $oras_destinatie $data_zbor $ora_zbor $ora_destinatie $pret_platit $clasa"
    fi
done < data.csv

if [[ "$zboruri_gasite" = false ]]; then
    echo "Nu s-au găsit înregistrări pentru luna introdusă."
fi
