#!/bin/bash

read -p "Introduceți orașul de plecare: " oras_plecare
read -p "Introduceți orașul de destinație: " oras_destinatie
echo "Acum cautam inregistrarile..."
sleep 3
# Lungimea maximă a fiecărei coloane
max_lungime_id=0
max_lungime_nume=0
max_lungime_prenume=0
max_lungime_email=0
max_lungime_telefon=0
max_lungime_varsta=0
max_lungime_oras_plecare=0
max_lungime_oras_destinatie=0
max_lungime_data_zbor=0
max_lungime_ora_zbor=0
max_lungime_ora_destinatie=0
max_lungime_pret_platit=0
max_lungime_clasa=0


# Ignoră prima linie din fișierul CSV (antetul)
tail -n +2 data.csv |
while IFS=',' read -r ID nume prenume email telefon varsta oras_plecare_csv oras_destinatie_csv data_zbor ora_zbor ora_destinatie pret_platit clasa; do
    if [[ "$oras_plecare_csv" = "$oras_plecare" && "$oras_destinatie_csv" = "$oras_destinatie" ]]; then
        # Actualizează lungimea maximă a fiecărei coloane
        if [[ ${#ID} -gt $max_lungime_id ]]; then
            max_lungime_id=${#ID}
        fi
        if [[ ${#nume} -gt $max_lungime_nume ]]; then
            max_lungime_nume=${#nume}
        fi
        if [[ ${#prenume} -gt $max_lungime_prenume ]]; then
            max_lungime_prenume=${#prenume}
        fi
        if [[ ${#email} -gt $max_lungime_email ]]; then
            max_lungime_email=${#email}
        fi
        if [[ ${#telefon} -gt $max_lungime_telefon ]]; then
            max_lungime_telefon=${#telefon}
        fi
        if [[ ${#varsta} -gt $max_lungime_varsta ]]; then
            max_lungime_varsta=${#varsta}
        fi
        if [[ ${#oras_plecare_csv} -gt $max_lungime_oras_plecare ]]; then
            max_lungime_oras_plecare=${#oras_plecare_csv}
        fi
        if [[ ${#oras_destinatie_csv} -gt $max_lungime_oras_destinatie ]]; then
            max_lungime_oras_destinatie=${#oras_destinatie_csv}
        fi
        if [[ ${#data_zbor} -gt $max_lungime_data_zbor ]]; then
            max_lungime_data_zbor=${#data_zbor}
        fi
        if [[ ${#ora_zbor} -gt $max_lungime_ora_zbor ]]; then
            max_lungime_ora_zbor=${#ora_zbor}
        fi
        if [[ ${#ora_destinatie} -gt $max_lungime_ora_destinatie ]]; then
            max_lungime_ora_destinatie=${#ora_destinatie}
        fi
        if [[ ${#pret_platit} -gt $max_lungime_pret_platit ]]; then
            max_lungime_pret_platit=${#pret_platit}
        fi
        if [[ ${#clasa} -gt $max_lungime_clasa ]]; then
            max_lungime_clasa=${#clasa}
        fi
    fi
done

# Afisare antet
gasit_inregistrare=false

# Ignoră prima linie din fișierul CSV (antetul)
tail -n +2 data.csv |
while IFS=',' read -r ID nume prenume email telefon varsta oras_plecare_csv oras_destinatie_csv data_zbor ora_zbor ora_destinatie pret_platit clasa; do
    if [[ "$oras_plecare_csv" = "$oras_plecare" && "$oras_destinatie_csv" = "$oras_destinatie" ]]; then
        # Afișează zborul cu spații fixe pentru aliniere
        gasit_inregistrare=true
        echo -n "$ID"
        for ((i = ${#ID}; i < max_lungime_id; i++)); do
            echo -n "  "
        done
        echo -n "   $nume"
        for ((i = ${#nume}; i < max_lungime_nume; i++)); do
            echo -n "  "
        done
        echo -n "   $prenume"
        for ((i = ${#prenume}; i < max_lungime_prenume; i++)); do
            echo -n "   "
        done
        echo -n "   $email"
        for ((i = ${#email}; i < max_lungime_email; i++)); do
            echo -n "  "
        done
        echo -n "   $telefon"
        for ((i = ${#telefon}; i < max_lungime_telefon; i++)); do
            echo -n "   "
        done
        echo -n "   $varsta"
        for ((i = ${#varsta}; i < max_lungime_varsta; i++)); do
            echo -n "  "
        done
        echo -n "   $oras_plecare_csv"
        for ((i = ${#oras_plecare_csv}; i < max_lungime_oras_plecare; i++)); do
            echo -n " "
        done
        echo -n "   $oras_destinatie_csv"
        for ((i = ${#oras_destinatie_csv}; i < max_lungime_oras_destinatie; i++)); do
            echo -n " "
        done
        echo -n "   $data_zbor"
        for ((i = ${#data_zbor}; i < max_lungime_data_zbor; i++)); do
            echo -n " "
        done
        echo -n "   $ora_zbor"
        for ((i = ${#ora_zbor}; i < max_lungime_ora_zbor; i++)); do
            echo -n " "
        done
        echo -n "   $ora_destinatie"
        for ((i = ${#ora_destinatie}; i < max_lungime_ora_destinatie; i++)); do
            echo -n " "
        done
        echo -n "   $pret_platit"
        for ((i = ${#pret_platit}; i < max_lungime_pret_platit; i++)); do
            echo -n " "
        done
        echo -n "   $clasa"
        for ((i = ${#clasa}; i < max_lungime_clasa; i++)); do
            echo -n " "
        done
        echo ""
    fi
done


if [ "$gasit_inregistrare" == "false" ]; then
   echo "Nu am gasit inregistrari cu oras de plecare $oras_plecare si destinatie $oras_destinatie!"
else
   sleep 3
   echo -e "
   Am terminat de afisat inregistarile!:)"
fi
