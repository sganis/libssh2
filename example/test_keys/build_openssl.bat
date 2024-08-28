@echo off
setlocal

set VERSION=3.3.1
set PATH=%PATH%;C:\Program Files\NASM;C:\Strawberry\perl\bin
set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%
set TEMP=C:\Temp
cd %TEMP%

rd /s /q openssl-openssl-%VERSION% 2>nul

if not exist openssl-%VERSION%.tar.gz (
	echo downloading...
	curl -L -O https://github.com/openssl/openssl/archive/refs/tags/openssl-%VERSION%.tar.gz
)
tar xf openssl-%VERSION%.tar.gz

cd openssl-openssl-%VERSION%
perl Configure 			        ^
    VC-CLANG-WIN64-CLANGASM-ARM ^
	no-shared                   ^
	--api=1.1.0                 ^
	--prefix=C:\openssl-clang	^
	--openssldir=C:\openssl-clang

nmake build_generated
nmake libcrypto.lib
nmake install_dev
cd %CD%
