#!/bin/bash

random(){
let "a=$RANDOM % $2"
if [ $a -lt $1  ]
then
	echo "1"
else
	echo "0"
fi
}
random $1 $2
