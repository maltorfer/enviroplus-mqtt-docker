#!/bin/bash


##### CHANGE this to accomodate your requirements

IP="altiraOffice"
SUBJECT_CA="/C=CH/ST=Zurich/L=Zurich/O=altorfer.net/OU=CA/CN=$IP"
SUBJECT_SERVER="/C=CH/ST=Zurich/L=Zurich/O=altorfer.net/OU=Server/CN=$IP"
SUBJECT_CLIENT="/C=CH/ST=Zurich/L=Zurich/O=altorfer.net/OU=Client/CN=$IP"


##### No changes below required 

function generate_CA () {
   echo "$SUBJECT_CA"
   openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA"  -days 720 -keyout ca.key -out ca.crt
}

function generate_server () {
   echo "$SUBJECT_SERVER"
   openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout server.key -out server.csr
   openssl x509 -req -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 720
}

function generate_client () {
   echo "$SUBJECT_CLIENT"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out client.csr -keyout client.key 
   openssl x509 -req -sha256 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 720
}

function copy_keys () {
  # copy server cert/key to MQTT
   sudo cp ca.crt ./docker/config/mosquitto/certs/.
   sudo cp server.crt ./docker/config/mosquitto/certs/.
   sudo cp server.key ./docker/config/mosquitto/certs/.
 # copy to telegraf for authenticating to MQTT
   sudo cp ca.crt ./docker/config/telegraf/.
   sudo cp client.crt ./docker/config/telegraf/.
   sudo cp client.key ./docker/config/telegraf/.
 # copy to directory of client (sensor machine)
   sudo cp ca.crt ./client/.
   sudo cp client.crt ./client/.
   sudo cp client.key ./client/.
}

generate_CA
generate_server
generate_client
copy_keys
