#!/bin/bash

labNumber=$1			#first argument
answer=$2			#second argument
labDir=${labNumber:0:4}		#substring labNumber to "Lab1"

#Main program loop
for file in Labs/$labDir/56000*/$labNumber.c
do
   if [[ -f "$file"  ]]; then
        #process the file with name in "$file"
        if (gcc $file &>/dev/null); then   #&>/dev/null mute the error output from gcc        
            echo -n "$compiled" >> result.txt 
            echo -n ";" >> result.txt #compilation is sucessful
            result=$(./a.out) #get result from running the program
            if [[ "$result" == $answer ]];then
                echo "$file : correct"
                echo "correct" >> result.txt #append correct to result file
            else
                echo "$file : wrong"
                echo "wrong" >> result.txt #append incorrect to result file
            fi   
        rm a.out
        
        else
        echo "$file : Compile error" #compilation fails

        fi
   fi
done
