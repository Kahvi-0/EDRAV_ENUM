#!/bin/bash

target=$1
RED="\e[31m"
ENDCOLOUR="\e[0m"

curl -s https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AVEDRFingerPrints.txt --output AVEDRFingerPrints.txt

while read p; do
	vendor=$(echo $p | awk -F ":" '{print$1}')
	proc=$(echo $p | awk -F ":" '{print$2}')
	#echo $p
	#echo $vendor
	#echo $proc
	if grep -F "$proc" $target; then
		echo ""
		echo -e "${RED}Looks like $vendor is running${ENDCOLOUR}"
		echo ""
	fi
	
done <AVEDRFingerPrints.txt

rm AVEDRFingerPrints.txt
