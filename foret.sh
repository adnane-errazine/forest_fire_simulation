#!/bin/bash

echo 'Hello dude, let s go simulé ton meilleur feu de forêt'

read -p "Quel taille veux tu donner à ta forêt = " taille
#read taille

read -p "choisir l'abcisse du point de départ du feu compris entre 0 et $taille :  " PDx
read -p "choisir l'ordonné dupoint de départ du feu compris entre 0 et $taille : " PDy


if [ "$PDx" -lt 0 ] || [  "$PDx" -ge "$taille" ]
then
	echo " le coordonnée x n'est pas correcte, choix aléatoire effectué"
	PDx=$(( $RANDOM %$(($taille))))
	if [ $PDy -lt 0 ] || [  $PDy -ge $taille ]	
	then
		echo "le coordonnée y n'est pas correcte, choix aléatoire effectué"
		PDy=$(( $RANDOM %$(($taille))))
	else
		echo "le coordonée y est bon! merci !"
	fi
else
	echo "le coordonée x est bon! merci !"
	if [ $PDy -lt 0 ] || [  $PDy -ge $taille ]	
	then
		echo "le coordonnée y n'est pas correcte : choix aléatoire"
		PDy=$(($RANDOM %$($taille)))
	else
		echo "le coordonée y est bon! merci !"
	fi
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
                if [ $reponse -eq 1  ] && [ $(($j +1)) -le  $(($n-1)) ] && [ $(($j +1)) -le  $(($n-1)) ] &&  [ ${arr2[$(($i+1)),$(($j+1))]} != '⬛'  ] && [ ${arr2[$(($i+1)),$(($j+1))]} != '⬜'  ] && [ ${arr2[$(($i+1)),$(($j+1))]} != '🌿'  ]
                then
			arr2[$(($i+1)),$(($j+1))]="🔥"
                fi
		if [ $reponse -eq 1  ] && [ $(($j -1)) -ge  0 ] && [ $(($j +1)) -le  $(($n-1)) ] &&  [ ${arr2[$(($i-1)),$(($j+1))]} != '⬛' ] &&  [ ${arr2[$(($i-1)),$(($j+1))]} != '⬜'  ]  &&  [ ${arr2[$(($i-1)),$(($j+1))]} != '🌿'  ]
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
echo $ti
echo ${arr[1,1]}
echo
for (( i=0 ; i<$n ; i++ ));
do
	arr[$i,$ti]= 🚁
	if [ $i -ne 0 ]
	then
	arr[$(($i-1)),$ti]=💦
	fi
	if [ $(($i-1)) -ne 0 ]
	then
	arr[$(($i-2)),$ti]=💦
	fi
	if [ $(($i-2)) -ne 0 ]
	then
	arr[(($i-3)),$ti]=🌿 
	fi
	printForet
	echo
	echo
	sleep 0.5
done 
arr[2,$ti]=🌿
	printForet
	sleep 0.5
arr[1,$ti]=🌿
	printForet
	sleep 0.5
arr[0,$ti]=🌿
	printForet
	sleep 0.5

}

main(){
	declare -A arr
	n=$taille
	initState arr
	startFire
	printForet
	#pompier
	while true
	do 
		
		printForet
		updateForet 8 10
		#read -t 1 -s -n 1 key 
		#if [ $key == "s" ]; then 
		#echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa"
		#	pompier
		#fi
		sleep 0.2
		clear
	done
}
main 2>>probleme.txt
