#!/bin/bash

CERT_FOLDER=$1
DOMAIN_NAME=$2
PRIV_KEY_NAME=$3
CERT_NAME=$4
PREFIX="$CERT_FOLDER/$DOMAIN_NAME"
SUBJECT="/C=US/ST=NY/L=NewYork/O=UmbrellaIT/OU=GodblessDevOps/CN=$DOMAIN_NAME"
PRIV_KEY_PATH="$CERT_FOLDER/$PRIV_KEY_NAME"
CERT_PATH="$CERT_FOLDER/$CERT_NAME"

rm -rf ${PRIV_KEY_PATH} ${CERT_PATH}
mkdir -p ${CERT_FOLDER}

#Generating ROOT pem files
openssl req -x509 -new -nodes -newkey rsa:2048 \
	-keyout ${PREFIX}.root.key -sha256 -days 825 \
	-out ${PREFIX}.root.pem -subj "$SUBJECT";

#Generating v3.ext file
cat <<EOF > $PREFIX.v3.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN_NAME
DNS.2 = *.$DOMAIN_NAME
EOF

openssl req -new -newkey rsa:2048 -sha256 -nodes \
	-newkey rsa:2048 -keyout ${PRIV_KEY_PATH} \
	-subj "$SUBJECT" \
	-out ${PREFIX}.csr;

#Generating certificate file
openssl x509 -req -in ${PREFIX}.csr \
	-CA ${PREFIX}.root.pem \
	-CAkey ${PREFIX}.root.key \
	-CAcreateserial \
	-out ${CERT_PATH} \
	-days 825 -sha256 -extfile ./${PREFIX}.v3.ext;

#Cleaning up the mess
rm -f ${PREFIX}.v3.ext ${PREFIX}.csr ${PREFIX}.root.pem ${PREFIX}.root.key ${PREFIX}.root.srl

exit 0
