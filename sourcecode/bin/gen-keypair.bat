@echo off
if "%OS%" == "Windows_NT" setlocal

REM you can modify JAVA_HOME to a absolute path
set JAVA_HOME=%JAVA_HOME%
set PATH=%JAVA_HOME%/bin

REM check environment.
if exist "%JAVA_HOME%\bin\keytool.exe" goto doInput
echo "ERROR:can NOT find %JAVA_HOME%\bin\keytool.exe"
goto end

:doInput
if ""%1"" == """" goto doHelp
if ""%2"" == """" goto doHelp
set teIP=%1
set gpeIP=%2
goto doGen

:doHelp
echo Usage:  gen-keypair  [IP address of TE] [IP address of GPE]
echo Arguments:
echo        [IP address of TE]: the IP address of server hosting TE.
echo        [IP address of GPE]: the IP address of server hosting GPE. 
goto end

:doGen
rd /S /Q certs
mkdir certs
echo Remove directory(certs/) generated by last execution.
echo -----------------------------------

echo - STEP1: generate keystore for GPE
REM keytool -genkey -dname "cn=%gpeIP% ou=M.POS o=M.POS c=HK" -alias %gpeIP% -keysize 1024 -keypass 111111 -keystore certs/gpe_%gpeIP%.jks -storepass 111111   
keytool -genkey -dname "cn=%gpeIP%" -alias %gpeIP% -validity 3650 -keyalg RSA -keysize 2048 -keypass 111111 -keystore certs/gpe_%gpeIP%.jks -storepass 111111   

echo - STEP2: export public certificate of GPE
keytool -export -alias %gpeIP% -file certs/gpe_%gpeIP%_public.crt -keystore certs/gpe_%gpeIP%.jks -storepass 111111

echo - STEP3: generate keystore for TE.
REM keytool -genkey -dname "cn=%teIP% ou=M.POS o=M.POS c=HK" -alias %teIP% -keysize 1024 -keypass 111111 -keystore certs/te_%teIP%.jks -storepass 111111
keytool -genkey -dname "cn=%teIP%" -alias %teIP% -validity 3650 -keyalg RSA -keysize 2048 -keypass 111111 -keystore certs/te_%teIP%.jks -storepass 111111

echo - STEP4: export public certificate of TE.
keytool -export -alias %teIP% -file certs/te_%teIP%_public.crt -keystore certs/te_%teIP%.jks -storepass 111111

echo - STEP5: import TE's public certificate into GPE's trusted keystore
keytool -noprompt -keystore certs/gpe_%gpeIP%_trust.jks -keypass 111111 -storepass 111111 -alias ca -import -trustcacerts -file certs/te_%teIP%_public.crt

echo - STEP6: import GPE's public certificate into TE's trusted keystore
keytool -noprompt -keystore certs/te_%teIP%_trust.jks -keypass 111111 -storepass 111111 -alias ca -import -trustcacerts -file certs/gpe_%gpeIP%_public.crt

echo -----------------------------------
echo OK!!! Now you should get 4 keystore files: gpe_%gpeIP%.jks, gpe_%gpeIP%_trust.jks, te_%teIP%.jks, te_%teIP%_trust.jks, and 2 public certificates: gpe_%gpeIP%_public.crt,te_%teIP%_public.crt

:end