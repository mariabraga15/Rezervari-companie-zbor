#!/bin/bash

function validate_names() {
    local name=$1
    if ! [[ $name =~ ^[a-zA-Z\s]+$ ]]; then
        return 1
    fi
    return 0
}

function validate_email() {
    local email=$1
    if ! [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
        return 1
    fi
    return 0
}

function validate_phone() {
    local phone=$1
    if ! [[ $phone =~ ^[0-9]{10}$ ]]; then
        return 1
    fi
    return 0
}

function validate_age() {
    local age=$1
    if (( age < 18 )) || (( age > 120 )); then
        return 1
    fi
    return 0
}

function validate_city() {
    local city=$1
    valid_cities=("Bucuresti" "Viena" "Atena" "Lisabona" "Madrid" "Roma" "Iasi" "Constanta" "Cluj-Napoca" "Barcelona" "Istanbul")
    if [[ ! " ${valid_cities[@]} " =~ " ${city} " ]]; then
        return 1
    fi
    return 0
}

function validate_flight_time() {
    local departure_time=$1
    local arrival_time=$2
    # Validare ora de plecare și sosire a zborului
    # Adăugați condițiile necesare pentru validarea timpului de zbor
    return 0
}

function validate_price() {
    local price=$1
    if ! [[ $price =~ ^[0-9]+(\.[0-9]{2})?$ ]]; then
        return 1
    fi
    return 0
}

function validate_class() {
    local class=$1
    valid_classes=("business" "first" "economy")
    if [[ ! " ${valid_classes[@]} " =~ " ${class} " ]]; then
        return 1
    fi
    return 0
}

function update_records() {
    echo "Introduceți ID-ul înregistrării pe care doriți să o actualizați:"
    read id

    if grep -q "^$id," "$csv_file"; then
        temp_file="temp.csv"
        grep -v "^$id," "$csv_file" > "$temp_file"

        name=$(grep "^$id," "$csv_file" | cut -d ',' -f 2)
        prenume=$(grep "^$id," "$csv_file" | cut -d ',' -f 3)

        email=$(grep "^$id," "$csv_file" | cut -d ',' -f 4)
        phone=$(grep "^$id," "$csv_file" | cut -d ',' -f 5)
        age=$(grep "^$id," "$csv_file" | cut -d ',' -f 6)
        departure_city=$(grep "^$id," "$csv_file" | cut -d ',' -f 7)
        destination_city=$(grep "^$id," "$csv_file" | cut -d ',' -f 8)
        flight_date=$(grep "^$id," "$csv_file" | cut -d ',' -f 9)
        departure_time=$(grep "^$id," "$csv_file" | cut -d ',' -f 10)
        arrival_time=$(grep "^$id," "$csv_file" | cut -d ',' -f 11)
        price=$(grep "^$id," "$csv_file" | cut -d ',' -f 12)
        class=$(grep "^$id," "$csv_file" | cut -d ',' -f 13)

        echo "Introduceți noile valori. Lăsați câmpurile goale pentru a păstra valorile existente."
        echo "Nume ($name):"
        read new_name
        if [[ -n $new_name ]]; then
            validate_names "$new_name"
            if [ $? -eq 0 ]; then
                name="$new_name"
            else
                echo "Numele introdus nu este valid."
                return
            fi
        fi
       echo "Prenume($prenume)":
       read new_prenume
        if [[ -n $new_prenume ]]; then
            validate_names "$new_prenume"
            if [ $? -eq 0 ]; then
                prenume="$new_prenume"
            else
                echo "Prenumele introdus nu este valid."
                return
            fi
        fi


        echo "Adresă de email ($email):"
        read new_email
        if [[ -n $new_email ]]; then
            validate_email "$new_email"
            if [ $? -eq 0 ]; then
                email="$new_email"
            else
                echo "Adresa de email introdusă nu este validă."
                return
            fi
        fi

        echo "Număr de telefon ($phone):"
        read new_phone
        if [[ -n $new_phone ]]; then
            validate_phone "$new_phone"
            if [ $? -eq 0 ]; then
                phone="$new_phone"
            else
                echo "Numărul de telefon introdus nu este valid."
                return
            fi
        fi

        echo "Vârstă ($age):"
        read new_age
        if [[ -n $new_age ]]; then
            validate_age "$new_age"
            if [ $? -eq 0 ]; then
                age="$new_age"
            else
                echo "Vârsta introdusă nu este validă."
                return
            fi
        fi

        echo "Oraș de plecare ($departure_city):"
        read new_departure_city
        if [[ -n $new_departure_city ]]; then
            validate_city "$new_departure_city"
            if [ $? -eq 0 ]; then
                departure_city="$new_departure_city"
            else
                echo "Orașul de plecare introdus nu este valid."
                return
            fi
        fi

        echo "Oraș de destinație ($destination_city):"
        read new_destination_city
        if [[ -n $new_destination_city ]]; then
            validate_city "$new_destination_city"
            if [ $? -eq 0 ]; then
                destination_city="$new_destination_city"
            else
                echo "Orașul de destinație introdus nu este valid."
                return
            fi
        fi

        echo "Dată zbor ($flight_date):"
        read new_flight_date
        if [[ -n $new_flight_date ]]; then
            # Validare dată zbor
            # Adăugați condițiile necesare pentru validarea datei de zbor
            flight_date="$new_flight_date"
        fi

        echo "Ora plecare ($departure_time):"
        read new_departure_time
        echo "Ora sosire ($arrival_time):"
        read new_arrival_time
        if [[ -n $new_departure_time && -n $new_arrival_time ]]; then
            validate_flight_time "$new_departure_time" "$new_arrival_time"
            if [ $? -eq 0 ]; then
                departure_time="$new_departure_time"
                arrival_time="$new_arrival_time"
            else
                echo "Intervalul orar introdus nu este valid."
                return
            fi
        fi

        echo "Preț plătit ($price):"
        read new_price
        if [[ -n $new_price ]]; then
            validate_price "$new_price"
            if [ $? -eq 0 ]; then
                price="$new_price"
            else
                echo "Prețul introdus nu este valid."
                return
            fi
        fi

        echo "Clasă ($class):"
        read new_class
        if [[ -n $new_class ]]; then
            validate_class "$new_class"
            if [ $? -eq 0 ]; then
                class="$new_class"
            else
                echo "Clasa introdusă nu este validă."
                return
            fi
        fi

        echo "$id,$name,$prenume,$email,$phone,$age,$departure_city,$destination_city,$flight_date,$departure_time,$arrival_time,$price,$class" >> "$temp_file"
        mv "$temp_file" "$csv_file"
        head -n 1 "$csv_file" > header.csv

# Sortarea datelor (fără header) după coloana "id" și salvarea rezultatului într-un fișier temporar
tail -n +2 "$csv_file" | sort -t',' -k1 -n > sorted_data.csv

# Concatenarea fișierului header cu datele sortate
cat header.csv sorted_data.csv > sorted_data_with_header.csv

# Suprascrie fișierul original cu datele sortate, inclusiv headerul
mv sorted_data_with_header.csv "$csv_file"

# Șterge fișierele temporare
rm header.csv sorted_data.csv
    echo "Înregistrarea cu ID-ul $id a fost actualizată cu succes"


    else
        echo "Înregistrarea cu ID-ul $id nu a fost găsită."
    fi
}

csv_file="data.csv"

update_records
