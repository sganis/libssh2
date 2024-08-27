:: Golddrive
:: 09/08/2018, San
:: Build openssl

@echo off
setlocal

set VERSION=3.3.1
set PATH=%PATH%;C:\Program Files\NASM;C:\Strawberry\perl\bin
set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%

rd /s /q openssl-%VERSION% 2>nul

tar xf openssl-%VERSION%.tar.gz

cd openssl-%VERSION%
perl Configure 			    ^
	no-shared               ^
	--api=1.1.0 ^
	--prefix=C:\openssl-x64	^
	--openssldir=C:\openssl-x64

nmake build_generated
nmake libcrypto.lib
nmake install_dev
cd ..
