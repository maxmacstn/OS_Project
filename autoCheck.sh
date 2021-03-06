#!/bin/bash

#-------------------|autoCheck.sh|---------------------------
# A shell script done for self-study of UNIX shell scripting.
#------------------------------------------------------------

usageText=$'Usage: ./autoCheck Lab{X}{Y} correctOutput where,\n{X} is lab number and {Y} is question number.'  #usage prompt
labNumber=$1  #first argument
answer=$2  #second argument
labDir=${labNumber:0:4}  #substring labNumber to "LabX"

#display usage text if not given proper arguments or given "-help"
if [ "$1" = "-help" ]; then
	echo "$usageText"
	exit 1
elif [ "$#" -ne 2 ]; then
	echo "Error: Invaild arguments. use -help for more information."
	exit 1
fi

#overwrite the results if they already exist
if [ -f ./result$labNumber.txt ]; then
	rm result$labNumber.txt
fi

#main program loop (for each file in the lab)
for file in Labs/$labDir/*/$labNumber.c
do

   studentID=$(basename $(dirname $file))  #Get the studentID from file path 

   if [[ -f "$file"  ]]; then  #if we find a source file
        if (gcc $file &>/dev/null); then  #if compilation is successful (&>/dev/null mute the error output from gcc)      
            echo -n "$studentID;" >> result$labNumber.txt  #write studentID to results
            result=$(./a.out)  #get result from running the program
            if [[ "$result" == $answer ]];then
                echo "$file : correct"
                echo "3" >> result$labNumber.txt  #append full score (three)
            else
                echo "$file : wrong"
                echo "2" >> result$labNumber.txt  #append score of two
            fi

        rm a.out  #cleanup the compiled program output
        
        else
            echo "$file : Compile error"  #compilation fails
	    echo -n "$studentID;" >> result$labNumber.txt #write studentID to results
	    echo "1" >> result$labNumber.txt  #append score of one

        fi
   fi
done

#Job is done. Exit with success.
exit 0
