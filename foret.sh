#!/bin/bash

echo 'Hello, this is a forest fire Simulation'

read -p "insert the size of your forest ! (We recommend 15 ) = " taille
#read taille

read -p "insert absciss of the fire's starting point  between 0 and $taille :  " PDx
read -p "insert ordinate of the fire's starting point between 0 and $taille : " PDy


if [ "$PDx" -lt 0 ] || [  "$PDx" -ge "$taille" ]
then
	PDx=$(( $RANDOM %$(($taille))))
fi
if [ $PDy -lt 0 ] || [  $PDy -ge $taille ]	
then
	PDy=$(( $RANDOM %$(($taille))))
fi

initState(){
arr=$1
for (( i=0; i<"$n" ; i++ ));
do
 for (( j=0 ; j < "$n" ; j++));
 do
		arr[$i,$j]="🌳"
done
done
}
array_copy()
{
# $1 original array name
# $2 new array name with the same content

    local INDEX
    eval "
        for INDEX in \"\${!$1[@]}\"
        do
            $2[\"\$INDEX\"]=\"\${$1[\$INDEX]}\"
        done
    "
}
updateForetFire(){
n=$taille
declare -A arr2
array_copy arr arr2
for (( i=0; i<"$n" ; i++ ));
do
 for (( j=0 ; j < "$n" ; j++));
 do
	if [ "${arr[$i,$j]}" == "🔥"   ]
	then
		reponse=`./random.sh $1 $2`   # for test purposes only !       
		if [ $reponse -eq 1 ]  && [ $(($i -1)) -ge  0 ] && [ ${arr2[$(($i-1)),$j]} != '⬛'  ] && [ ${arr2[$(($i-1)),$j]} != '⬜'  ] && [ ${arr2[$(($i-1)),$j]} != '🌿'  ]
		then
			arr2[$(($i-1)),$j]="🔥"
		fi
		reponse=`./random.sh $1	$2`       
                if [ $reponse -eq 1  ] && [ $(($i +1)) -le  $(($n-1)) ] && [ ${arr2[$(($i+1)),$j]} != '⬛'  ] && [ ${arr2[$(($i+1)),$j]} != '⬜'  ] && [ ${arr2[$(($i+1)),$j]} != '🌿'  ]
                then
                        arr2[$(($i+1)),$j]="🔥"
                fi
		reponse=`./random.sh $1 $2`
                if [ $reponse -eq 1  ] && [ $(($j +1)) -le  $(($n-1)) ] &&  [ ${arr2[$i,$(($j+1))]} != '⬛'  ] &&  [ ${arr2[$i,$(($j+1))]} != '⬜'  ] &&  [ ${arr2[$i,$(($j+1))]} != '🌿'  ]
                then
			arr2[$i,$(($j+1))]="🔥"
                fi
                reponse=`./random.sh $1 $2`
                if [ $reponse -eq 1  ] && [ $(($j -1)) -ge  0 ] &&  [ ${arr2[$i,$(($j-1))]} != '⬛'  ] &&  [ ${arr2[$i,$(($j-1))]} != '⬜'  ] &&  [ ${arr2[$i,$(($j-1))]} != '🌿'  ]
                then
			arr2[$i,$(($j-1))]="🔥"
                fi
                reponse=`./random.sh $1 $2`
                if [ $reponse -eq 1  ] && [ $(($j -1)) -ge  0 ] && [ $(($i -1)) -ge  0 ] &&  [ ${arr2[$(($i-1)),$(($j-1))]} != '⬛'  ] &&  [ ${arr2[$(($i-1)),$(($j-1))]} != '⬜'  ] &&  [ ${arr2[$(($i-1)),$(($j-1))]} != '🌿'  ]
                then
			arr2[$(($i-1)),$(($j-1))]="🔥"
                fi
                reponse=`./random.sh $1 $2`
                if [ $reponse -eq 1  ] && [ $(($j +1)) -le  $(($n-1)) ] && [ $(($j +1)) -le  $(($n-1)) ] &&  [[ ${arr2[$(($i+1)),$(($j+1))]} != '⬛'  ]] && [[ ${arr2[$(($i+1)),$(($j+1))]} != '⬜'  ]] && [[ ${arr2[$(($i+1)),$(($j+1))]} != '🌿'  ]]
                then
			arr2[$(($i+1)),$(($j+1))]="🔥"
                fi
		if [ $reponse -eq 1  ] && [ $(($j -1)) -ge  0 ] && [ $(($j +1)) -le  $(($n-1)) ] &&  [[ ${arr2[$(($i-1)),$(($j+1))]} != '⬛' ]] &&  [[ ${arr2[$(($i-1)),$(($j+1))]} != '⬜'  ]]  &&  [[ ${arr2[$(($i-1)),$(($j+1))]} != '🌿'  ]]
                then
                        arr2[$(($i-1)),$(($j+1))]="🔥"
		fi
                if [ $reponse -eq 1 ] && [ $(($j -1)) -ge  0 ] && [ $(($i +1)) -le  $(($n-1)) ] &&  [ ${arr2[$(($i+1)),$(($j-1))]} != '⬛'  ] &&  [ ${arr2[$(($i+1)),$(($j-1))]} != '⬜'  ] &&  [ ${arr2[$(($i+1)),$(($j-1))]} != '🌿'  ]
                then
                        arr2[$(($i+1)),$(($j-1))]="🔥"
                fi
		reponse=`./random.sh 4 10`
                if [ $reponse -eq 1 ] 
                then
                        arr2[$i,$j]="⬛"
                fi
	elif [ "${arr[$i,$j]}" == "⬛" ] 
	then 
		reponse=`./random.sh 30 100`
		if [ $reponse -eq 1 ]
		then arr2[$i,$j]="⬜"
		fi
	 elif [ "${arr[$i,$j]}" == "⬜" ] 
        then 
                reponse=`./random.sh 5 100`
                if [ $reponse -eq 1 ]
                then arr2[$i,$j]="🌿"
                fi
         elif [ "${arr[$i,$j]}" == "🌿" ] 
        then
                reponse=`./random.sh 1 5`
                if [ $reponse -eq 1 ]
                then arr2[$i,$j]="🌳"
                fi
	elif [ "${arr[$i,$j]}" == "🌳" ] 
	 then
       		 reponse2=`./random.sh 1 1000`
        	if [ $reponse2 -eq 1 ]
        	then
        	arr2[$i,$j]="🔥"
        	echo " Natural Lightning struck"
        	fi
fi
done
done

array_copy arr2 arr

}



updateForet()
{
	updateForetFire $1 $2
	startFireRandomly 1 10
}
printForet(){
	echo "Don't press w ! Poseidon will get mad !!!"
	for ((  a=0 ; a< "$n" ; a++ ));
	do
 		for ((  b=0 ; b < "$n" ; b++ ));
 		do
  			echo -n "${arr[$a,$b]}"
		done
		echo
	done
}
printForetArr2(){
        for ((  a=0 ; a< "$n" ; a++ ));
        do
                for ((  b=0 ; b < "$n" ; b++ ));
                do
                        echo -n "|${arr2[$a,$b]}"
                done
                echo
        done
}

startFire(){

#	local ti=$(($RANDOM %$(($taille))))
#	local tj=$(($RANDOM %$(($taille))))
#	arr[$ti,$tj]="🔥"
	arr[$PDx,$PDy]="🔥"
}
startFireRandomly()
{
        local reponse2=`./random.sh $1 $2`
        if [ $reponse2 -eq 1 ]
	then
	 local ti=$(($RANDOM %$(($taille))))
        local tj=$(($RANDOM %$(($taille))))
        arr[$ti,$tj]="🔥"
	echo " Zeus is mad again ! he casted magical fire that burns everything after impregnating your mom"
        fi
}
pompier(){

local ti=$(($RANDOM %$(($taille-1))))
for (( i=0 ; i<$n ; i++ ));
do
	echo "BEHOLD POSEIDON WAVE !"
	arr[$ti,$i]=🌊
	waveLength=10
	for (( T3=1 ; T3<$waveLength ; T3++ ));
	do
	arr[$ti,$(($i-$T3))]=💦
	arr[$ti,$(($i-$(($waveLength-1))))]="🌿" 
	done
	printForet
	sleep 0.1
	clear
	if [ $((i+1)) -eq $n ]
	then
		echo "BEHOLD POSEIDON WAVE !"
		arr[$ti,$i]=💦
		for (( j=$(($i-$waveLength)) ; j<$n ; j++  ))
		do
			arr[$ti,$j]=🌿
			printForet
			sleep 0.1
			clear
		done
	fi
done 
}

main(){
	declare -A arr
	n=$taille
	initState arr
	startFire
	while true
	do 
		printForet
		updateForet 5 10
		read -t 1 -s -n 1 key 
		sleep 0.1
		clear
		if [[ $key = "w" ]]; then 
		clear
		pompier
		fi
	done
}
main 2>>probleme.txt