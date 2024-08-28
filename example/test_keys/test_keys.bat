@echo off
set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%
set EXEDIR=build\example


:: copy authorized_keys to server
type %TEST_KEYS%\key_rsa.pub > authorized_keys
type %TEST_KEYS%\key_rsa_signed.pub >> authorized_keys
type %TEST_KEYS%\key_rsa_openssh.pub >> authorized_keys
type %TEST_KEYS%\key_dsa.pub >> authorized_keys
type %TEST_KEYS%\key_ecdsa.pub >> authorized_keys
type %TEST_KEYS%\key_ed25519.pub >> authorized_keys

:: fix permissions
icacls %TEST_KEYS% /c /t /inheritance:d
icacls %TEST_KEYS% /c /t /grant %TEST_USER%:F
icacls %TEST_KEYS% /c /t /grant SYSTEM:F
icacls %TEST_KEYS% /c /t /remove Administrator ^
    BUILTIN\Administrators BUILTIN Everyone Users "Authenticated Users"

echo:
echo ssh id_rsa... 
ssh %TEST_USER%@%TEST_HOST% -oPreferredAuthentications=publickey -i %TEST_KEYS%\key_rsa echo openssh PASSED
%EXEDIR%\keys.exe %TEST_HOST% %TEST_USER% %TEST_KEYS%\key_rsa
echo:
echo ssh key_rsa_openssh... 
ssh %TEST_USER%@%TEST_HOST% -oPreferredAuthentications=publickey -i %TEST_KEYS%\key_rsa_openssh echo openssh PASSED
%EXEDIR%\keys.exe %TEST_HOST% %TEST_USER% %TEST_KEYS%\key_rsa_openssh
echo:
echo ssh key_rsa_signed... 
ssh %TEST_USER%@%TEST_HOST% -oPreferredAuthentications=publickey -i %TEST_KEYS%\key_rsa_signed echo openssh PASSED
%EXEDIR%\keys.exe %TEST_HOST% %TEST_USER% %TEST_KEYS%\key_rsa_signed
echo:
echo ssh key_ecdsa...
ssh %TEST_USER%@%TEST_HOST% -oPreferredAuthentications=publickey -i %TEST_KEYS%\key_ecdsa echo openssh PASSED
%EXEDIR%\keys.exe %TEST_HOST% %TEST_USER% %TEST_KEYS%\key_ecdsa
echo:
echo ssh key_ed25519...
ssh %TEST_USER%@%TEST_HOST% -oPreferredAuthentications=publickey -i %TEST_KEYS%\key_ed25519 echo openssh PASSED
%EXEDIR%\keys.exe %TEST_HOST% %TEST_USER% pub %TEST_KEYS%\key_ed25519
