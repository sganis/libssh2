@echo off
set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%
set HOST=192.168.64.1
set USER=san
set KEYDIR=%DIR%\..\..\tests
set EXEDIR=build\example


:: copy authorized_keys to server
type %KEYDIR%\key_rsa.pub > authorized_keys
type %KEYDIR%\key_rsa_signed.pub >> authorized_keys
type %KEYDIR%\key_rsa_openssh.pub >> authorized_keys
type %KEYDIR%\key_dsa.pub >> authorized_keys
type %KEYDIR%\key_ecdsa.pub >> authorized_keys
type %KEYDIR%\key_ed25519.pub >> authorized_keys

:: fix permissions
icacls %KEYDIR% /c /t /inheritance:d
icacls %KEYDIR% /c /t /grant %USER%:F
icacls %KEYDIR% /c /t /grant SYSTEM:F
icacls %KEYDIR% /c /t /remove Administrator BUILTIN\Administrators BUILTIN Everyone Users "Authenticated Users"

echo:
echo ssh id_rsa... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_rsa echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_rsa.pub %KEYDIR%\key_rsa
echo:
echo ssh key_rsa_openssh... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_rsa_openssh echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_rsa_openssh.pub %KEYDIR%\key_rsa_openssh
echo:
echo ssh key_rsa_signed... 
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_rsa_signed echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_rsa_signed.pub %KEYDIR%\key_rsa_signed
echo:
echo ssh key_dsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_dsa echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_dsa.pub %KEYDIR%\key_dsa
echo:
echo ssh key_ecdsa...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_ecdsa echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_ecdsa.pub %KEYDIR%\key_ecdsa
echo:
echo ssh key_ed25519...
ssh %USER%@%HOST% -oPreferredAuthentications=publickey -i %KEYDIR%\key_ed25519 echo openssh PASSED
%EXEDIR%\keys.exe %HOST% %USER% %KEYDIR%\key_ed25519.pub %KEYDIR%\key_ed25519
