#!/bin/bash

csv_file="data.csv"

while [ "$opt" != "q" ]; do
    echo -e "Ati ajuns la sortare. Alegeti o optiune:
    1) După orașul de plecare și destinație.
    2) După dată.
    3) Ordonează alfabetic (nume).
    q) Ieșire.
    "

    read -r opt

    case "$opt" in
        1) ./sortare_plecare_destinatie.sh "$csv_file";;
        2) ./sortare_data_rezervare.sh "$csv_file" ;;
        3) ./sortare_alfabetica.sh ;;
        q) echo "Am ieșit din meniul cu sortări. Veti reveni la cel principal..." ;;
        *) echo "Opțiune invalidă" ;;
    esac
done
