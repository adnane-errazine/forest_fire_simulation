#!/bin/bash
binomial=0
bernoulli=0
while [ $binomial -ne 10000 ]
do
if [ ` ./random.sh $1 $2 ` -eq 1 ]
then 
((bernoulli++))
fi
let "binomial++"
done
echo  $bernoulli / $binomial | bc -l

