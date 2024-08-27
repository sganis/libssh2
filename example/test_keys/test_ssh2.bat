@echo off
set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%
set HOST=192.168.100.202
set USER=san
set KEYDIR=%DIR%\..\..\tests
set EXEDIR=build\example\Release

echo ssh id_rsa... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_rsa echo PASSED
%EXEDIR%\example-keys.exe %HOST% %USER% %KEYDIR%\key_rsa.pub %KEYDIR%\key_rsa

echo ssh key_rsa_openssh... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_rsa_openssh echo PASSED
%EXEDIR%\example-keys.exe %HOST% %USER% %KEYDIR%\key_rsa_openssh.pub %KEYDIR%\key_rsa_openssh

echo ssh key_dsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_dsa echo PASSED
%EXEDIR%\example-keys.exe %HOST% %USER% %KEYDIR%\key_dsa.pub %KEYDIR%\key_dsa

echo ssh key_ecdsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_ecdsa echo PASSED
%EXEDIR%\example-keys.exe %HOST% %USER% %KEYDIR%\key_ecdsa.pub %KEYDIR%\key_ecdsa

echo ssh key_ed25519...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_ed25519 echo PASSED
%EXEDIR%\example-keys.exe %HOST% %USER% %KEYDIR%\key_ed25519.pub %KEYDIR%\key_ed25519
