# EDRAV_ENUM

Place the output if the list of services and/or processes from target hosts into a file and run as shown below.

```
tasklist /svc

sc query | findstr _NAME
```


```
./AEChecker.sh Processes.txt
```


# AEenum.ps1

```
IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AEcheck.ps1')
```
