#!/bin/bash
i=78999

clear
echo -e "Bine ati venit in baza de date a companiei Airways!
         Alegeti ce operatiune doriti sa faceti:
         1.Creati baza de date(daca nu exista)
         2.Adaugati o inregistrare
         3.Modificati inregistrare
         4.Stergere inregistrare
         5.Sortare(dupa diverse criterii)
         6.Afisare statistici
         7.Afisare inregistrari
         8.Clear
         9.Gaseste rezervarile (dupa diverse criterii)
         0.EXIT     "
while [ $i -ne 0 ]
do

read i
case $i in
1)./create_DB.sh;;
2) ./insert.sh;;
3)./modificari.sh;;
4)file="data.csv"
  read -p "Introduceti ID de sters: " id
 ./stergere.sh $file $id;;
5)./meniu_sortari.sh;;
6) ./statistica_destinatii.sh
   ./statistica_varsta.sh;;
7)./tabel.sh "data.csv";;
8)clear
  echo -e "
         Alegeti ce operatiune doriti sa faceti:
         1.Creati baza de date(daca nu exista)
         2.Adaugati o inregistrare
         3.Modificati inregistrare
         4.Stergere inregistrare
         5.Sortare(dupa diverse criterii)
         6.Afisare statistici
         7.Afisare inregistrari
         8.Clear
         9.Gaseste rezervarile (dupa diverse criterii)
         0.EXIT "            ;;
9) ./cautari_menu.sh;;
0)echo "EXIT.Am iesit"
   sleep 1
    clear;;
*)echo "Optiune invalida";;
esac
done
