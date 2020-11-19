# enviroplus-mqtt-docker
My solution for handling enviroplus air quality sensors using mosquitto, telegraf, influxdb and grafana using docker.

Requirements:
- Host for running Docker containers
- Raspberry PI (I use a zero)
- Enviro+ Sensor https://shop.pimoroni.com/products/enviro
- Optional: Particle Sensor https://shop.pimoroni.com/products/pms5003-particulate-matter-sensor-with-cable

## Install (Server/Docker)
I do use my Synology Storage to run the docker containers. The CPU and memory footprint is marginale if you don't run 100's of sensors.


## Create Server- and Client-keys
I'm using keys client- and server-keys to authenticate and secure the MQTT connection. Keys and in MQTT can be used in various ways; in particular they can be used for client identification based on the client-key content (CN) or just to authenticate the client. I'm using the keys only to authenticate the client. The identification of the client itself is done by username (without password as we use the key to secure). This way I can use the same client key as many times as I want. In production environment where you use a lot of sensors and different "customers" you would probably use another setup; but for my home setup it's enough.

- Use the mqtt-keys-make.sh script to create the keys for MQTT server and client

## Install (Client)
- Follow the steps on https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-enviro-plus to install the required libraries/components
- Copy the contents of the client directory to your raspberry




## References that helped me 
[https://gabrieltanner.org/blog/grafana-sensor-visualization]


![alt text](https://github.com/maltorfer/enviroplus-mqtt-docker/blob/main/grafana_dashboard_multi.png?raw=true)
