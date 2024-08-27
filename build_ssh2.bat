:: Golddrive
:: 09/08/2018, San
:: Build libssh2

@echo off
setlocal


cmake .. ^
 -DCMAKE_INSTALL_PREFIX="C:/libssh2-x64"		^
 -DCMAKE_BUILD_TYPE=Release						^
 -DCRYPTO_BACKEND=OpenSSL               		^
 -DOPENSSL_ROOT_DIR=C:/openssl-x64 				^
 -DENABLE_ZLIB_COMPRESSION=OFF 					^
 -DBUILD_TESTING=OFF 							^
 -DENABLE_CRYPT_NONE=ON							^
 -DCLEAR_MEMORY=OFF
cmake --build . --config Release --target install

xcopy C:\libssh2-x64\lib\libssh2.lib %DIR%\..\vendor\libssh2\lib\x64\libssh2.lib* /y /s /i
xcopy C:\libssh2-x64\include %DIR%\..\vendor\libssh2\include /y /s /i
cd ..

