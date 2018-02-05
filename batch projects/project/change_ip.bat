@echo off
echo                      dipankar pal (c) 2018
echo                 ........  github/deep5050 ........
echo msgbox "this batch script will help you to modify wi-fi or ethernet ip address right from this single window ((ATTENTION: ran as Admin !!))" >%temp%\temp.vbs
cscript /nologo %temp%\temp.vbs

:start
SET /P choice=1.Wi-Fi / 2.Ethernet ? : 

IF %choice% == 2 ( SET name=Ethernet )
If %choice% == 1 ( SET name=Wi-Fi )


:start2
SET /P mode=1.static (enter mannually)  / 2.DHCP (obtain automatically)? :
IF %mode% == 1 (GOTO :set )
IF %mode% == 2 (GOTO :dhcp) ELSE (GOTO :start2)
:set
SET /P ip=enter new IP address :
SET /P mask=enter subnet mask :
SET /P gateway=enter default gateway :
GOTO :static
:dns
echo choose DNS server :
GOTO :overrideDHCPdns


:static
netsh interface ipv4 set address %name% static %ip% %mask% %gateway%
GOTO :dns

:dhcp
netsh interface ipv4 set address %name% DHCP
netsh interface ipv4 set dnsservers %name% DHCP
:prompt
SET /P flag=want to override DNS servers (y / n) ? : 
IF "%flag%" == "y" ( GOTO :overrideDHCPdns )
IF "%flag%" == "Y" ( GOTO :overrideDHCPdns )
IF "%flag%" == "n" (GOTO :end)
IF "%flag%" == "N" (GOTO :end) else ( GOTO :prompt)

:overrideDHCPdns
SET /P list=1.enter mannually / 2.use popular dns to encrypt and secure your connection ?: 
IF %list% == 1 (GOTO :userEntry)
IF %list% == 2 (GOTO :list)
:userEntry
SET /P dns1=enter primary DNS address :
SET /P dns2=enter alternate DNS address :

:changeDns
netsh interface ipv4 set dns %name% static %dns1% 1>>errors.txt
netsh interface ipv4 add dns %name% index=2 %dns2% 1>>errors.txt
GOTO :end

:list

echo 1.OpenDns (default)
echo 2.AdGuard (default)
echo 3.AdGuard ( Family Protection)
echo 4.Google
echo 5.Level 3 Dns
echo 6.DNS.WATCH
echo 7.OpenNIC
echo 8.norton(default)
echo 9.Norton (pornography protection)
echo 10.Norton(pornography + malware protection)

SET /P user=please enter your choice:
echo you entered %user%
IF %user% == 1 GOTO :opendns
IF %user% == 2 GOTO :adguardDefault
IF %user% == 3 GOTO :adguardFamily
IF %user% == 4 GOTO :google
IF %user% == 5 GOTO :level3
IF %user% == 6 GOTO :dnswatch
IF %user% == 7 GOTO :openNic
IF %user% == 8 GOTO :nortonDefault
IF %user% == 9 GOTO :nortonPornProtect
IF %user% == 10 GOTO :nortonAll


:opendns
cls
SET dns1=208.67.222.222
SET dns2=208.67.220.220
GOTO :changeDns

:adguardDefault
SET dns1=176.103.130.130
SET dns2=176.103.130.131
GOTO :changeDns

:adguardFamily
SET dns1=176.103.130.132
SET dns2=176.103.130.134
GOTO :changeDns

:google
SET dns1=8.8.8.8
SET dns2=8.8.4.4
GOTO :changeDns

:level3
cls
SET dns1=209.244.0.3
SET dns2=209.244.0.4
GOTO :changeDns

:dnswatch
cls
SET dns1=84.200.69.80
SET dns2=84.200.70.40
GOTO :changeDns

:openNic
cls
SET dns1=69.195.152.204
SET dns2=23.94.60.240
GOTO :changeDns

:nortonDefault
cls
SET dns1=199.85.126.10
SET dns2=199.85.127.10
GOTO :changeDns

:nortonPornProtect
cls
SET dns1=199.85.126.10
SET dns2=199.85.127.10
GOTO :changeDns

:nortonAll
cls
SET dns1=199.85.126.10
SET dns2=199.85.127.10
GOTO :changeDns




:end
netsh interface ipv4 show config %name%
echo msgbox "sucessfully applied" >%temp%\temp.vbs
cscript /nologo %temp%\temp.vbs
