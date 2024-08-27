@echo off
set HOST=192.168.64.1
set USER=san
set HOME=%HOMEDRIVE%%HOMEPATH%
set DIR=build4\example\Release

echo ssh id_rsa... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_rsa echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_rsa.pub %HOME%\.ssh\id_rsa

echo ssh id_rsa_openssh... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_rsa_openssh echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_rsa_openssh.pub %HOME%\.ssh\id_rsa_openssh

echo ssh id_rsa_signed...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_rsa_signed echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_rsa_signed.pub %HOME%\.ssh\id_rsa_signed

echo ssh id_dsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_dsa echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_dsa.pub %HOME%\.ssh\id_dsa

echo ssh id_ecdsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_ecdsa echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_ecdsa.pub %HOME%\.ssh\id_ecdsa

echo ssh id_ed25519...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %HOME%\.ssh\id_ed25519 echo PASSED
%DIR%\example-ssh2.exe %HOST% %USER% %HOME%\.ssh\id_ed25519.pub %HOME%\.ssh\id_ed25519
