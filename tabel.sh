#!/bin/bash
file=$1


if [[ ! -f "$file" ]]; then
    echo "Fișierul $file nu există."
    exit 1
fi


function afisare_tabel() {
    
    cap_tabel=$(head -n 1 "$file")

    
    inregistrari=$(tail -n +2 "$file")

    
    cap_tabel=$(echo "$cap_tabel" | sed 's/,/  /g')
    echo "$cap_tabel"

    
    echo "------------------------------------------------------------------------------------------------------------------------------"

    
    echo "$inregistrari" | column -s ',' -t | sed 's/  \([^ ]\)/ \1/g'
}




afisare_tabel
