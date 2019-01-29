#!/usr/bin/bash

echo "Select Category:"
cat ./material/selection.txt && echo " "
printf "> " 
read choice && echo " "

filename=${choice}"-easy.txt"
number_of_q=$( wc -l "$filename" | sed 's/^[ \t]*//;s/[ \t]*$//' | cut -d ' ' -f 1 )

for value in $( seq 1 $number_of_q );
do

line=$( sed "${value}q;d" $filename )

hint=$( echo $line | awk -F',' '{ print $1 }' )
word=$( echo $line | awk -F',' '{ print $2 }' )
echo "Hint: \"${hint}\"" && echo " " 

#Init
temp_word=""
wrong=0
for value in $( seq 1 ${#word} );
do
         printf "_ " 
	 temp_word=${temp_word}"_ "
done

printf "   score 0, remaining wrong guess 10 \n"

wrong=10
wrong_word=""
true_key=""
score=0
point=0
c2=0
flag_space=0

while read -ep "> " text; do
	
	flag="T"
        r_score=0

	check_more_word=$( echo "$word" | grep -r "$text" )
        if [ "$check_more_word" = '' ]
        then
                ((wrong--))
                flag="F"
	else
	      #more than 1 charactor
              for value in $( seq 0 $((${#text}-1)));
	      do
		      #check space or not
		      if [ "$text" = '' ]
		      then
			     flag_space=$((flag_space+1))
			     positions=$( echo $word | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
		      else
			     positions=$( echo $word | grep -o . | grep -n $text | cut -d ':' -f 1 )
		      fi

                      positions=( $positions )
		      if [ ${#positions[@]} -gt 1 ]
		      then
			     for value in $( seq 0 $((${#positions[@]}-1)) );
			     do
				     index=${positions[$value]}
				     index=$((index+index))
				     temp_word=$( echo "${temp_word:0:index-2}""${word:positions[$value]-1:1}"" ""${temp_word:index}" )
			     done
		      else
			      index=${positions}
			      index=$((index+index))
                              temp_word=$( echo "${temp_word:0:index-2}""${word:positions-1:1}"" ""${temp_word:index}" )
		      fi

                      #/-------check-same-or-not--------/
		      flag_T_in_word="F"
                      if [ "$text" = '' ]
                      then
                               positions_1=$( echo "$true_key" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
                               if [ "${flag_space}" -gt "1" ]
                               then
                                       flag_T_in_word="T"
                               fi
                      else
                                positions_1=$( echo "$true_key" | grep -o . | grep -n $text | cut -d ':' -f 1 )
                                if [ -z "$positions_1" ]
                                then
                                      flag_T_in_word="F"
                                else
                                      flag_T_in_word="T"
                                fi
                      fi

                      if [ -z "$positions" ]
                      then
                               r_score=0
                      else
                               if [ "${flag_T_in_word}" = "F" ]
                               then
                                   true_key="${true_key}""${text}"
                                   r_score=$(( 100/${#word}*${#positions[@]} ))
                                   c2=$(( ${#positions[@]}+c2 ))
                               fi
                      fi
		done

	        score=$(( score+r_score ))
	        if [[ $c2 == ${#word} ]]
	        then
	         	score=100
	        fi
	         
		printf "%s   score %s, remaining wrong guess %s" "$temp_word" "$score" "$wrong"

               if [ ${wrong} -lt 10 ] 
               then
	                if [ ${wrong} -eq 9 ] && [ "${flag}" = "F" ]
	                then
                             wrong_word="$text"
                        else
                             flag_F_in_word="F"
		             if [ "$text" = '' ]
                             then
                                   positions=$( echo "$wrong_word" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
                             else
                                   positions=$( echo "$wrong_word" | grep -o . | grep -n $text | cut -d ':' -f 1 )
                             fi

		             if [ -z "$positions" ] 
		             then
                                   flag_F_in_word="F"
		             else
                                   flag_F_in_word="T"
		             fi

        		     if [ "${flag}" = "F" ] && [ "${flag_F_in_word}" = "F" ]
		             then
                                   wrong_word="${wrong_word}"", ""$text"
		             fi
	               fi
                       printf ", wrong guessed: %s\n" "$wrong_word"
               else
	               printf "\n"
	       fi

               if [ "${score}" = "100" ] 
	       then
                     echo ""
	             echo "==================================================================="
	             echo "Mission Success!!"
	             echo "==================================================================="
	             point=1
                     break
	       fi

	       if [ "${wrong}" = "0" ]
               then
                     echo ""
	             echo "==================================================================="
	             echo "Mission Fail!! That word is ${word}" 
	             echo "==================================================================="
                     break
		fi
        fi

done  

all_score=$(( all_score+point ))
echo ""
echo "Summary score ""${all_score} ""/"" ${number_of_q}"
echo ""

done



	then
           #text=$( echo "${text:m_index:1}" )
	   check_more_word=$( echo "$word" | grep -r "$text" )
	   if [ "$check_more_word" = '' ]
	   then
		((wrong--))
		flag="F"
	   else
		flag="T"
                r_score=0
		for value in $( seq 0 $((${#text}-1)));
                do
#-------------
		     #echo "${text:value:1}"
		     if [ "$text" = '' ]
		     then
			     flag_space=$((flag_space+1))
			     positions=$( echo $word | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
		     else
			     positions=$( echo $word | grep -o . | grep -n $text | cut -d ':' -f 1 )
		     fi
                     positions=( $positions )
		     if [ ${#positions[@]} -gt 1 ]
		     then
			     for value in $( seq 0 $((${#positions[@]}-1)) );
			     do
				     index=${positions[$value]}
				     index=$((index+index))
				     temp_word=$( echo "${temp_word:0:index-2}""${word:positions[$value]-1:1}"" ""${temp_word:index}" )
			     done
		      else
			      index=${positions}
			      index=$((index+index))
                              temp_word=$( echo "${temp_word:0:index-2}""${word:positions-1:1}"" ""${temp_word:index}" )
		      fi

                      #/-------check-same-or-not--------/
		      flag_T_in_word="F"
                      if [ "$text" = '' ]
                      then
                               positions_1=$( echo "$true_key" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
                               if [ "${flag_space}" -gt "1" ]
                               then
                                       flag_T_in_word="T"
                               fi
                      else
                                positions_1=$( echo "$true_key" | grep -o . | grep -n $text | cut -d ':' -f 1 )
                                if [ -z "$positions_1" ]
                                then
                                      flag_T_in_word="F"
                                else
                                      flag_T_in_word="T"
                                fi
                      fi

                      if [ -z "$positions" ]
                      then
                               r_score=0
                      else
                               if [ "${flag_T_in_word}" = "F" ]
                               then
                                   true_key="${true_key}""${text}"
                                   r_score=$(( 100/${#word}*${#positions[@]} ))
                                   c2=$(( ${#positions[@]}+c2 ))
                               fi
                      fi

	         printf "%s   score %s, remaining wrong guess %s" "$temp_word" "$score" "$wrong"

                 if [ ${wrong} -lt 10 ] 
                 then
	                if [ ${wrong} -eq 9 ] && [ "${flag}" = "F" ]
	                then
                             wrong_word="$text"
                        else
                             flag_F_in_word="F"
		             if [ "$text" = '' ]
                             then
                                   positions=$( echo "$wrong_word" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
                             else
                                   positions=$( echo "$wrong_word" | grep -o . | grep -n $text | cut -d ':' -f 1 )
                             fi

		             if [ -z "$positions" ] 
		             then
                                   flag_F_in_word="F"
		             else
                                   flag_F_in_word="T"
		             fi

        		     if [ "${flag}" = "F" ] && [ "${flag_F_in_word}" = "F" ]
		             then
                                   wrong_word="${wrong_word}"", ""$text"
		             fi
	               fi
                       printf ", wrong guessed: %s\n" "$wrong_word"
                else
	               printf "\n"
	        fi
#---------------
		done
	   fi

        else
              flag="T"
              r_score=0	   


	#/--------check--one-char--------/ 
        if [ "$text" = '' ]
	then
	    flag_space=$((flag_space+1))
            positions=$( echo $word | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
        else
            positions=$( echo $word | grep -o . | grep -n $text | cut -d ':' -f 1 )
	fi

	if [ -z "$positions" ]
        then
               #echo "\$var is empty"
	       ((wrong--))
	       flag="F"
        else
               #echo "\$var is NOT empty"
	       positions=( $positions )
	       if [ ${#positions[@]} -gt 1 ] 
	       then
		   for value in $( seq 0 $((${#positions[@]}-1)) );
                   do
		       index=${positions[$value]}
		       index=$((index+index))
		       temp_word=$( echo "${temp_word:0:index-2}""${word:positions[$value]-1:1}"" ""${temp_word:index}" )
                   done
		else
                   index=${positions}
                   index=$((index+index))
	           temp_word=$( echo "${temp_word:0:index-2}""${word:positions-1:1}"" ""${temp_word:index}" )
		fi

		score=$(( score+r_score ))
                if [[ $c2 == ${#word} ]]
                then
                       score=100
                fi


        fi
       
	#/-------check-same-or-not--------/
	flag_T_in_word="F"
        if [ "$text" = '' ]
        then
          	positions_1=$( echo "$true_key" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
		if [ "${flag_space}" -gt "1" ]
		then
		       flag_T_in_word="T"
		fi
	else
          	positions_1=$( echo "$true_key" | grep -o . | grep -n $text | cut -d ':' -f 1 )
		if [ -z "$positions_1" ]
                then
                   flag_T_in_word="F"
                else
                   flag_T_in_word="T"
                fi
	fi

        
        if [ -z "$positions" ]  
	then
	      r_score=0
        else
             if [ "${flag_T_in_word}" = "F" ]
	     then
		 true_key="${true_key}""${text}"
                 r_score=$(( 100/${#word}*${#positions[@]} ))
		 c2=$(( ${#positions[@]}+c2 ))
	     fi
        fi

        fi
	#/----end else

	#/--------score-all---------/
	score=$(( score+r_score ))
	if [[ $c2 == ${#word} ]]
	then
		score=100
	fi

	#/---------final---print---------/
	printf "%s   score %s, remaining wrong guess %s" "$temp_word" "$score" "$wrong"
        if [ ${wrong} -lt 10 ] 
        then
	     if [ ${wrong} -eq 9 ] && [ "${flag}" = "F" ]
	     then
                wrong_word="$text"
             else

                flag_F_in_word="F"
		if [ "$text" = '' ]
                then
                     positions=$( echo "$wrong_word" | grep -o . | grep -n "\s" | cut -d ':' -f 1 )
                else
                     positions=$( echo "$wrong_word" | grep -o . | grep -n $text | cut -d ':' -f 1 )
                fi
		if [ -z "$positions" ] 
		then
                      flag_F_in_word="F"
		else
                      flag_F_in_word="T"
		fi


		if [ "${flag}" = "F" ] && [ "${flag_F_in_word}" = "F" ]
		then
                      wrong_word="${wrong_word}"", ""$text"
		fi
	     fi
             printf ", wrong guessed: %s\n" "$wrong_word"
        else
	     printf "\n"
	fi

        #-----/continue 

	#/--------pass-this-task-or-not---------/
        if [ "${score}" = "100" ] 
	then
            echo ""
	    echo "==================================================================="
	    echo "Mission Success!!"
	    echo "==================================================================="
	    point=1
            break
	fi

	if [ "${wrong}" = "0" ]
        then
            echo ""
	    echo "==================================================================="
	    echo "Mission Fail!! That word is ${word}" 
	    echo "==================================================================="
            break
        fi
done   

all_score=$(( all_score+point ))
echo ""
echo "Summary score ""${all_score} ""/"" ${number_of_q}"
echo ""

done

