#!/bin/bash

while [ "$option" != "q" ]
do
    echo -e "Caută înregistrări:
        a) nume și prenume
        b) orașul de plecare și cel de destinație
        c) dată
        d) lună
        e) ora de plecare (dimineața, după-amiaza, seara)
        q) pentru ieșire"

    read -r option

    case $option in
        "a") ./cautare_inregistrare.sh ;;
        "b") ./cautare_orase.sh ;;
        "c") ./cautare_data.sh ;;
        "d") ./cautare_luna.sh ;;
        "e") ./cautare_ora.sh ;;

        "q") echo "Ieșire din program." ;;
        *) echo "Căutare invalidă." ;;
    esac
done
