# EDR / AV Enumeration Tools

## Local on Windows
###AEenum.ps1

```
IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AEcheck.ps1')
```

## Remote from Linux
### AERemote.sh
```
wget https://raw.githubusercontent.com/Kahvi-0/EDRAV_ENUM/main/AERemote.sh && chmod +x AERemote.sh
```

Usage:
```
AVRemote.sh [user] [password] [domain] [target host]
```

Example:
```
./AEChecker.sh CoolUser 'Password123!' lab 10.10.10.1
```

## Local on Linux
### AEChecker.sh

Place the output if the list of services and/or processes from target hosts into a file and run as shown below.

```
tasklist /svc

sc query | findstr _NAME
```


```
./AEChecker.sh Processes.txt
```



