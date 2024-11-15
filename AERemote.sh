#!/bin/bash

#Usage
#AVRemote.sh [user] [password] [domain] [target host]
#Example: ./AEChecker.sh CoolUser 'Password123!' lab 10.10.10.1
 
RED="\e[31m"
ENDCOLOUR="\e[0m"

curl -s https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AVEDRFingerPrints.txt --output AVEDRFingerPrints.txt

echo "Using user $1"

wget https://raw.githubusercontent.com/fortra/impacket/refs/heads/master/examples/tstool.py
wget https://raw.githubusercontent.com/fortra/impacket/refs/heads/master/examples/services.py

echo "======================================="
echo " Trying to get processes on $4 "
echo "======================================="
python3 ./tstool.py $3/$1:$2@$4 tasklist > $4Process.txt
echo "done"
echo "======================================" 
echo " Trying to get services on $4 " 
echo "======================================"
python3 ./services.py $3/$1:$2@$4 list >> $4Services.txt

echo "done"


cat $4Process.txt | awk -F ' ' '{print$1}' > $4Processes.txt
cat $4Services.txt | tr -s ' ' |  awk -F '+-+' 'BEGIN { ORS=" " }; {print"SERVICE:"}{print$1} {printf"\n"}'  >> $4Services2.txt

echo "============================================="
echo " Checking what AV/EDR might be on $4 "
echo "============================================="

target=$4Services2.txt

while read p; do
	vendor=$(echo $p | awk -F ":" '{print$1}')
	proc=$(echo $p | awk -F ":" '{print$2}')
	if grep -w -F "$proc" $target; then 
		echo " "
		echo -e "${RED}Looks like service $vendor is on the host ${ENDCOLOUR}"
		echo " "
	fi

done <AVEDRFingerPrints.txt

target=$4Processes.txt

while read p; do
	vendor=$(echo $p | awk -F ":" '{print$1}')
	proc=$(echo $p | awk -F ":" '{print$2}')
	if grep -w -F "$proc" $target; then
		echo ""
		echo -e "${RED}Looks like process $vendor is running${ENDCOLOUR}" 
		echo ""	
	fi
done <AVEDRFingerPrints.txt

rm AVEDRFingerPrints.txt $4Services2.txt $4Processes.txt $4Process.txt $4Services.txt
