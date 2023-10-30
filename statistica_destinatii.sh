#!/bin/bash

csv_file="data.csv"
declare -A destinations
declare -A months

total_passengers=0

# Inițializează toate destinațiile cu 0
destinations["Roma"]=0
destinations["Lisabona"]=0
destinations["Viena"]=0
destinations["Bucuresti"]=0
destinations["Atena"]=0
destinations["Paris"]=0
destinations["Budapesta"]=0
destinations["Madrid"]=0
destinations["Larnaca"]=0
destinations["Berlin"]=0
destinations["Corfu"]=0
destinations["Istanbul"]=0
destinations["Antalya"]=0
destinations["Iasi"]=0
destinations["Timisoara"]=0

# Inițializează toate lunile cu 0
months["01"]=0
months["02"]=0
months["03"]=0
months["04"]=0
months["05"]=0
months["06"]=0
months["07"]=0
months["08"]=0
months["09"]=0
months["10"]=0
months["11"]=0
months["12"]=0

# Citește fișierul CSV și numără destinațiile, lunile și calculează vârsta medie
while IFS=, read -r id nume prenume email telefon varsta oras_plecare oras_destinatie data_zbor ora_zbor ora_sosire pret_platit clasa; do
  for destination in "${!destinations[@]}"; do
    if [ "$oras_destinatie" == "$destination" ]; then
      ((destinations[$destination]++))
    fi
  done

  month=${data_zbor:5:2}
  ((months[$month]++))



  ((total_passengers++))
done < "$csv_file"

# Sortează destinațiile în funcție de numărul de rezervări în ordine descrescătoare
sorted_destinations=()
for destination in "${!destinations[@]}"; do
  sorted_destinations+=("$destination")
done
sorted_destinations=($(for destination in "${sorted_destinations[@]}"; do
  echo "$destination ${destinations[$destination]}"
done | sort -rn -k2 | awk '{print $1}'))

# Sortează lunile în funcție de numărul de rezervări în ordine descrescătoare
sorted_months=()
for month in "${!months[@]}"; do
  sorted_months+=("$month")
done
sorted_months=($(for month in "${sorted_months[@]}"; do
  echo "$month ${months[$month]}"
done | sort -rn -k2 | awk '{print $1}'))

# Calculează vârsta medie a călătorilor


# Afișează procentul rezervărilor pentru cele trei cele mai căutate destinații
echo "Procentul rezervărilor pentru cele trei cele mai căutate destinații:"
counter=0
for destination in "${sorted_destinations[@]}"; do
  count="${destinations[$destination]}"
  percentage=$(bc <<< "scale=4; $count/$total_passengers * 100")
  echo "$destination: $percentage% din rezervări"

  ((counter++))
  if [ $counter -eq 3 ]; then
    break
  fi
done

# Afișează procentul rezervărilor pentru cele trei luni cele mai aglomerate
echo "Procentul rezervărilor pentru cele trei luni cele mai aglomerate:"
counter=0
for month in "${sorted_months[@]}"; do
  count="${months[$month]}"
  percentage=$(bc <<< "scale=4; $count/$total_passengers * 100")
  echo "Luna $month: $percentage% din rezervări"

  ((counter++))
  if [ $counter -eq 3 ]; then
    break
  fi
done
