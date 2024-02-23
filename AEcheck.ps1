$WebResponse = Invoke-WebRequest https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AVEDRFingerPrints.txt -UseBasicParsing

$processes = (Get-WmiObject Win32_Process | Select-Object ProcessName | Out-String) -split "`r`n" -replace '\s','' | Where-Object {$_.trim() -ne ""} |  Sort-Object | Get-Unique
$services = (wmic service get name | Out-String)  -split "\r?\n|\r" -replace '\s','' | Where-Object {$_.trim() -ne ""}

echo "------------------"
echo "Checking services"
echo "------------------"
foreach($line in $services) {
     ($WebResponse.tostring() -split "[`r`n]" | Select-String -Pattern "`:$line$") -replace ':',' is running from process'
}

echo "-----------------"
echo "Checking processes"
echo "-----------------"
foreach($line in $processes) {
    ($WebResponse.tostring() -split "[`r`n]" | Select-String -SimpleMatch "`:$line")  -replace ':',' is running from service'
}
