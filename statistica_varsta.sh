#!/bin/bash

csv_file="data.csv"

# Definirea grupei de vârstă
declare -A age_groups
age_groups["18-25"]=0
age_groups["26-35"]=0
age_groups["36-45"]=0
age_groups["46-55"]=0
age_groups["56+"]=0

# Citirea fișierului CSV și numărarea vârstelor în fiecare grupă
while IFS=, read -r id nume prenume email telefon varsta oras_plecare oras_destinatie data_zbor ora_zbor ora_sosire pret_platit clasa; do
  if [[ $varsta =~ ^[0-9]+$ ]]; then
    if [ $varsta -ge 18 ] && [ $varsta -le 25 ]; then
      ((age_groups["18-25"]++))
    elif [ $varsta -ge 26 ] && [ $varsta -le 35 ]; then
      ((age_groups["26-35"]++))
    elif [ $varsta -ge 36 ] && [ $varsta -le 45 ]; then
      ((age_groups["36-45"]++))
    elif [ $varsta -ge 46 ] && [ $varsta -le 55 ]; then
      ((age_groups["46-55"]++))
    else
      ((age_groups["56+"]++))
    fi
  fi
done < "$csv_file"

# Sortarea grupei de vârstă în funcție de numărul de persoane în ordine descrescătoare
sorted_groups=()
for group in "${!age_groups[@]}"; do
  sorted_groups+=("$group ${age_groups[$group]}")
done
sorted_groups=($(for group in "${sorted_groups[@]}"; do
  echo "$group"
done | sort -rn -k2 | awk '{print $1}'))

# Afișarea celor trei cele mai frecvente grupe de vârstă
echo "Cele trei cele mai frecvente grupe de vârstă sunt:"
counter=0
for group in "${sorted_groups[@]}"; do
  echo "$group"

  ((counter++))
  if [ $counter -eq 3 ]; then
    break
  fi
done
