#!/bin/bash

states=("California" "Oregan" "Washington" "New_York" "Kansas")

isThere=0

for state in ${states[@]}
do
	if [ $state == "Hawaii" ]; then
		echo "Hawaii is the best"
		isThere=1
	fi
done

if [ $isThere = 0 ]; then
	echo "I'm not fond of Hawaii"
fi

nums=($(seq 0 1 9))

for num in ${nums[@]}
do
	if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]; then
		echo $num
	fi
done

lsDir=$(ls)
for item in ${lsDir[@]}
do
	echo $item
done

findVar=$(find /home -type f -perm 777 2> /dev/null)
for item in ${findVar[@]}
do
	echo $item
done




