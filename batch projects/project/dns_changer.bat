@echo off

echo  1.Wi-Fi / 2.Ethernet ?
SET /P name=enter your choice :
IF %name% == 1 GOTO :wifi
IF %name% == 2 GOTO :ethernet

:wifi
SET interface=Wi-Fi
GOTO :menu

:ethernet
SET interface=Ethernet

:menu
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
SET primaryDns=208.67.222.222
SET alternateDns=208.67.220.220
GOTO :changeDns

:adguardDefault
SET primaryDns=176.103.130.130
SET alternateDns=176.103.130.131
GOTO :changeDns

:adguardFamily
SET primaryDns=176.103.130.132
SET alternateDns=176.103.130.134
GOTO :changeDns

:google
SET primaryDns=8.8.8.8
SET alternateDns=8.8.4.4
GOTO :changeDns

:level3
cls
SET primaryDns=209.244.0.3
SET alternateDns=209.244.0.4
GOTO :changeDns

:dnswatch
cls
SET primaryDns=84.200.69.80
SET alternateDns=84.200.70.40
GOTO :changeDns

:openNic
cls
SET primaryDns=69.195.152.204
SET alternateDns=23.94.60.240
GOTO :changeDns

:nortonDefault
cls
SET primaryDns=199.85.126.10
SET alternateDns=199.85.127.10
GOTO :changeDns

:nortonPornProtect
cls
SET primaryDns=199.85.126.10
SET alternateDns=199.85.127.10
GOTO :changeDns

:nortonAll
cls
SET primaryDns=199.85.126.10
SET alternateDns=199.85.127.10
GOTO :changeDns

:changeDns
netsh interface ipv4 set dns %interface% static %primarydns% 
netsh interface ipv4 add dns %interface% index=2 %alternateDns%


:end
echo msgbox "sucessfully applied" >%temp%\temp.vbs
cscript /nologo %temp%\temp.vbs
pause