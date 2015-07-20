#!/bin/sh

JAVA_HOME=

# you can modify JAVA_HOME to a absolute path, if the varialble doesn't exist
if [ -z "$JAVA_HOME" ]; then
  JAVA_HOME=/home/ramonli/tool/jdk1.5.0_19
fi
PATH=$JAVA_HOME/bin:$PATH

#  check environment.
#if [ -r "$MLOTTERY_TE_HOME"/WEB-INF/web.xml ]; then
#  echo "Use MLOTTERY_TE_HOME: $MLOTTERY_TE_HOME"
#else
#  echo "can NOT find $MLOTTERY_TE_HOME/WEB-INF/web.xml"
#  exit 0
#fi

if [ $# != 2 ]; then
  echo Usage:  certs  [IP address of TE] [IP address of IGPE]
  echo Arguments:
  echo        [IP address of TE]: the IP address of server hosting TE.
  echo        [IP address of IGPE]: the IP address of server hosting IGPE.
  exit 0
fi

teIP=$1
igpeIP=$2

# Remove directory generated by last execution.
CERT_DIR=certs
rm -rf $CERT_DIR
mkdir $CERT_DIR
echo Remove directory\("$CERT_DIR"/\) generated by last execution.
echo ------------------------------------

echo - STEP1: generate keystore for IGPE
keytool -genkey -dname "cn=$igpeIP" -alias $igpeIP -validity 3650 -keyalg RSA -keysize 2048 -keypass 111111 -keystore "$CERT_DIR"/igpe_"$igpeIP".jks -storepass 111111

echo - STEP2: export public certificate of IGPE
keytool -export -alias $igpeIP -file "$CERT_DIR"/igpe_"$igpeIP"_public.crt -keystore "$CERT_DIR"/igpe_"$igpeIP".jks -storepass 111111

echo - STEP3: generate keystore for TE.
keytool -genkey -dname "cn=$teIP" -alias $teIP -validity 3650 -keyalg RSA -keysize 2048 -keypass 111111 -keystore "$CERT_DIR"/te_"$teIP".jks -storepass 111111

echo - STEP4: export public certificate of TE.
keytool -export -alias $teIP -file certs/te_"$teIP"_public.crt -keystore "$CERT_DIR"/te_"$teIP".jks -storepass 111111

echo - STEP5: import TE's public certificate into IGPE's trusted keystore
keytool -noprompt -keystore "$CERT_DIR"/igpe_"$igpeIP"_trust.jks -keypass 111111 -storepass 111111 -alias ca -import -trustcacerts -file "$CERT_DIR"/te_"$teIP"_public.crt

echo - STEP6: import IGPE's public certificate into TE's trusted keystore
keytool -noprompt -keystore "$CERT_DIR"/te_"$teIP"_trust.jks -keypass 111111 -storepass 111111 -alias ca -import -trustcacerts -file "$CERT_DIR"/igpe_"$igpeIP"_public.crt

echo ------------------------------------
echo OK!!! Now you should get 4 keystore files: igpe_"$igpeIP".jks, igpe_"$igpeIP"_trust.jks, te_"$teIP".jks, te_"$teIP"_trust.jks, and 2 public certificates: igpe_"$igpeIP"_public.crt,te_"$teIP"_public.crt
