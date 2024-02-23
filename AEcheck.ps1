curl https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AVEDRFingerPrints.txt -o AVEDRFingerPrints.txt

$processes = (Get-WmiObject Win32_Process | Select-Object ProcessName | Out-String) -split "`r`n" -replace '\s','' | Where-Object {$_.trim() -ne ""} |  Sort-Object | Get-Unique
$services = (wmic service get name | Out-String)  -split "\r?\n|\r" -replace '\s','' | Where-Object {$_.trim() -ne ""}

echo "------------------"
echo "Checking processes"
echo "------------------"
foreach($line in $services) {
    (Get-Content ./AVEDRFingerPrints.txt | Select-String -Pattern "`:$line$") -replace ':',' is running from process'
}

echo "-----------------"
echo "Checking services"
echo "-----------------"
foreach($line in $processes) {
    (Get-Content ./AVEDRFingerPrints.txt | Select-String -Pattern "`:$line$")  -replace ':',' is running from service'
}

del AVEDRFingerPrints.txt
