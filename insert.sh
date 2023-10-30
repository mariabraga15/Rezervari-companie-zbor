#!/bin/bash
function validate_names(){
local name=$1
if ! [[ $name =~ ^[a-zA-Z\s]+$ ]]; then
        return 1
    fi
 return 0
}
function generate_unique_id() {
    local last_id=0
    file="data.csv"

    if [[ -f "$file" ]]; then

        last_id=$(awk -F',' '{print $1}' "$file" | sort -n | tail -1)


        if [[ ! "$last_id" =~ ^[0-9]+$ ]]; then
            last_id=0
        fi
    fi

    # Incrementarea valorii ultimului ID
    while true; do
        last_id=$((last_id + 1))


        if ! grep -q "^$last_id," "$file"; then
            break
        fi
    done

    # Returnează noul ID
    echo "$last_id"
}




 function validate_email() {
  email=$1
  if [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
    return 0
  else
    return 1
  fi
}

function validate_phone() {
  phone=$1
  if [[ $phone =~ ^[0-9]{10}$ ]]; then
    return 0
  else
    return 1
  fi
}
 validate_city() {
  orase_op=("Bucuresti" "Roma" "Paris" "Atena" "Budapesta" "Madrid" "Larnaca" "Berlin" "Viena" "Corfu" "Lisabona" "Istanbul" "Antalya" "Iasi" "Timisoara")
  city=$1

  for oras_suportat in "${orase_op[@]}"; do
    if [ "$oras_suportat" == "$city" ]; then
      return 0
    fi
  done
  return 1
}
function validare_ora() {
    local ora=$1
    local nume=$2
    local prenume=$3
    local data=$4
    local hour=$(echo "$ora" | cut -d ':' -f1 | tr -d '[:space:]')
    local minute=$(echo "$ora" | cut -d ':' -f2| tr -d '[:space:]')

    # Verifică formatul orei în HH:MM


    # Verifică dacă orele și minutele sunt valide
    if (( hour < 0 || hour > 23 || minute < 0 || minute > 59 )); then
        return 1
    fi






    return 0
}




validare_sosire() {
  departure_time=$1
  arrival_time=$2

  departure_hours=$( echo $departure_time | cut -d ':' -f1 )
  departure_minutes=$( echo $departure_time | cut -d ':' -f2 )
  arrival_hours=$( echo $arrival_time | cut -d ':' -f1 )
  arrival_minutes=$(echo $arrival_time | cut -d ':' -f2 )

  if [ "$departure_hours" -gt "$arrival_hours" ]; then
    return 1
  elif [ "$departure_hours" -eq "$arrival_hours" ] && [ "$departure_minutes" -gt "$arrival_minutes" ]; then
    return 1
  else
    return 0
  fi
}








function validate_paid_price() {
  price=$1

  # Verificăm dacă prețul plătit este un număr cu două zecimale
  if [[ ! $price =~ ^[0-9]+(\.[0-9]{2})?$ ]]; then
    return 1  # Prețul plătit nu este valid
  fi

  return 0  # Prețul plătit este valid
}


function validate_flight_class() {
  flight_class=$(echo "$1" | tr '[:upper:]' '[:lower:]')

  # Verificăm dacă clasa zborului este una dintre valorile permise
  if [[ "$flight_class" == "economy" || "$flight_class" == "business" || "$flight_class" == "first" ]]; then
    return 0  # Clasa zborului este validă
  else
    return 1  # Clasa zborului nu este validă
  fi
}

validate_age() {
  age=$1
  if [[ $age =~ ^[0-9]+$ ]]; then
    if (( age >= 18 && age <= 120 )); then
      return 0
    fi
  fi
  return 1
}


function add_record(){
id=$(generate_unique_id)
#NUME
while true; do
read -p "Nume:" nume
validate_names "$nume"
if [ $? -eq 0 ]; then
break
else
echo "Numele ar trebui sa contina doar litere"
fi
done

#PRENUME
while true; do
read -p "Prenume:" prenume
validate_names "$prenume"
if [ $? -eq 0 ]; then
break
else
echo "Prenumele ar trebui sa contina doar litere"
fi
done


#EMAIL
while true; do
    read -p "Email: " email
    validate_email "$email"
    if [ $? -eq 0 ]; then
      break
    else
      echo "Eroare: Adresa de email invalidă."
    fi
  done

#TELEFON
while true; do
    read -p "Telefon: " telefon
    validate_phone "$telefon"
    if [ $? -eq 0 ]; then
      break
    else
      echo "Eroare: Numărul de telefon invalid. Trebuie să conțină exact 10 cifre."
    fi
  done

#Varsta
while true; do
  read -p "Vârsta(18-120): " varsta
  validate_age "$varsta"
  if [ $? -eq 0 ]; then
    break
  else
    echo "Eroare: Vârsta invalidă. Trebuie să fie un număr întreg între 18 și 120."
  fi
done


#ORAS PLECARE
while true; do
    read -p "Oras plecare:" oras_plecare
    validate_city "$oras_plecare"
    if [ $? -eq 0 ]; then
      break
    else
      echo "Eroare: Compania nu opereaza zboruri dinspre acest oras"
    fi
  done

#ORAS DESTINATIE
while true; do
  read -p "Oras destinatie: " oras_dest
  validate_city "$oras_dest"
  if [ $? -eq 0 ]; then
    if [ "$oras_plecare" == "$oras_dest" ]; then
      same_city_flag=1
    else
      same_city_flag=0
    fi

    if [ $same_city_flag -eq 0 ]; then
      break
    else
      echo "Nu poti calatori in acelasi oras!"
    fi
  else
    echo "Compania nu opereaza zboruri spre aceasta destinatie!"
  fi
done


#citire data zbor
today=$(date '+%Y/%m/%d')

while true; do
  read -p  "Data zbor (in format YYYY/MM/DD): " data_zbor


  # Validate input:
  date -d "$data_zbor" > /dev/null 2>&1

  if [ $? != 0 ]; then
    echo "Data invalida! Mai incearca o data."
  else
    # Compare input with today:
    if [[ $data_zbor < $today ]]; then
      echo "Data [$data_zbor] este anterioara celei de azi [$today]."
    else
      break
    fi
  fi
done


#citire ora zbor
while true; do
  read -p "Ora zbor (HH:MM): " ora_zbor
  validare_ora "$ora_zbor" "$nume" "$prenume" "$data"
  if [ $? -eq 0 ]; then
    break
  else
    echo "Ora zborului nu are format corect sau persoana are deja un zbor la aceasta ora!"
  fi
done

#Ora sosire destinatie
while true; do
  read -p "Ora destinatie (HH:MM): " ora_dest
  validare_ora "$ora_dest" "$nume" "$prenume" "$data"
  if [ $? -eq 0 ]; then
    validare_sosire "$ora_zbor" "$ora_dest"
    if [ $? -eq 0 ]; then
      break
    else
      echo "Ora la care se ajunge la destinatie nu poate fi mai mica decat cea de plecare"
    fi
  else
    echo "Ora destinatie nu are format corect sau persoana are deja un zbor la aceasta ora!"
  fi
done


#PRET PLATIT
while true; do
  read -p "Pret platit (lei, 2 zecimale): " pret_platit
  validate_paid_price "$pret_platit"
  if [ $? -eq 0 ]; then
    break
  else
    echo "Pret invalid! Trebuie sa fie un numar cu 2 zecimale."
  fi
done

#VALIDARE CLASA
while true; do
  read -p "Clasa (economy/business/first): " clasa
  validate_flight_class "$clasa"
  if [ $? -eq 0 ]; then
    break
  else
    echo "Clasa invalida! Alege una dintre cele 3 optiuni listate!"
  fi
done

inregistrare="$id,$nume,$prenume,$email,$telefon,$varsta,$oras_plecare,$oras_dest,$data_zbor,$ora_zbor,$ora_dest,$pret_platit,$clasa"


echo "Acum adaug inregistrarea..."
sleep 3
echo "$inregistrare" >> data.csv
echo "Inregistrare adaugata cu succes! :)"

}

add_record
