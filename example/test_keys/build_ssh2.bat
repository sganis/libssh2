@echo off
setlocal

set DIR=%~dp0
set DIR=%DIR:~0,-1%
set CWD=%CD%

mkdir build
cd build
cmake ..\..\..                                  ^
 -DCMAKE_INSTALL_PREFIX=C:/libssh2   		    ^
 -DCRYPTO_BACKEND=OpenSSL               		^
 -DOPENSSL_ROOT_DIR=C:/openssl 				    ^
 -DBUILD_TESTING=OFF 							
cmake --build . --config Release --target install

cd %CD%


