#!/bin/bash

read -p "Introduceți ora de plecare (dimineata/dupa-amiaza/seara): " ora_cautata
echo "Cautăm înregistrări $ora_cautata"
sleep 3

zboruri_gasite=false

while IFS=',' read -r ID nume prenume email telefon varsta oras_plecare oras_destinatie data_zbor ora_zbor ora_destinatie pret_platit clasa; do
    ora_zbor_formatata=$(echo "$ora_zbor" | tr ';' ':')  # Inlocuim ';' cu ':' pentru formatul orei
    hour=$(date -d "$ora_zbor_formatata" +"%H")
    case $ora_cautata in
        "dimineata")
            if [[ $(echo "$hour < 12" | bc -l) -eq 1 ]]; then
                zboruri_gasite=true
                echo "$ID $nume $prenume  $email  $telefon  $varsta $oras_plecare $oras_destinatie $data_zbor  $ora_zbor $ora_destinatie $pret_platit $clasa"
            fi
            ;;
        "dupa-amiaza")
            if [[ $(echo "$hour >= 12 && $hour < 18" | bc -l) -eq 1 ]]; then
                zboruri_gasite=true
                echo "$ID $nume $prenume  $email  $telefon  $varsta $oras_plecare $oras_destinatie $data_zbor  $ora_zbor $ora_destinatie $pret_platit $clasa"
            fi
            ;;
        "seara")
            if [[ $(echo "$hour >= 18" | bc -l) -eq 1 ]]; then
                zboruri_gasite=true
                echo "$ID $nume $prenume  $email  $telefon  $varsta $oras_plecare $oras_destinatie $data_zbor  $ora_zbor $ora_destinatie $pret_platit $clasa"
            fi
            ;;
        *)
            echo "Ora de plecare introdusă nu este validă."
            exit 1
            ;;
    esac
done < <(tail -n +2 data.csv)

# Afișează un mesaj de eroare dacă nu s-au găsit zboruri
if [[ "$zboruri_gasite" = false ]]; then
    echo "Nu s-au găsit înregistrări pentru ora de plecare introdusă."
fi
