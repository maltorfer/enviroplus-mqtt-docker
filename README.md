# enviroplus-mqtt-docker
My solution for handling enviroplus air quality sensors using mosquitto, telegraf, influxdb and grafana using docker.

Requirements:
- Host for running Docker containers
- Raspberry PI (I use a zero)
- Enviro+ Sensor https://shop.pimoroni.com/products/enviro
- Optional: Particle Sensor https://shop.pimoroni.com/products/pms5003-particulate-matter-sensor-with-cable

## 1. Create Server- and Client-keys
I'm using keys client- and server-keys to authenticate and secure the MQTT connection. Keys and in MQTT can be used in various ways; in particular they can be used for client identification based on the client-key content (CN) or just to authenticate the client. I'm using the keys only to authenticate the client. The identification of the client itself is done by username (without password as we use the key to secure). This way I can use the same client key as many times as I want. In production environment where you use a lot of sensors and different "customers" you would probably use another setup; but for my home setup it's enough.

```
chmod 755 mqtt-keys-make.sh
./mqtt-keys-make.sh
```

Use the mqtt-keys-make.sh script to create the keys for MQTT server and client

## 2. Install (Server/Docker)
I do use my Synology NAS to run the docker containers. The CPU and memory footprint is marginale if you don't run 100's of sensors and tons of other applications on your storage.

- Check and change the config files in the corresponding directory. Unless you change name of db, username/pw for influx and client/server certificate/key names, there's probably not much to change except for the IP-Adress of your MQTT and influx server (likely the IP of the docker host) in the <code>telegraf.conf</code> file in the config/telegraf directory. Note that this IP-Address has two be changed at two locations; once for the MQTT server and once for the influxdb database container.
- Copy the contents of the docker directory to your docker host
- Start the docker server by executing <code>docker-compose</code> in the directory where you copie your files. 

## 3. Create influxdb database

Once your docker containers are up an running, create the influxdb database using influx on the docker container by executing:

<code>docker exec -it influxdb influx</code>

Enter the following at the prompt to create user/database:

```
CREATE DATABASE sensors
CREATE USER telegraf WITH PASSWORD 'telegraf'
GRANT ALL ON sensors TO telegraf
```


## Install (Client)
- Follow the steps on https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-enviro-plus to install the required libraries/components
- Copy the contents of the client directory to your raspberry




## References that helped me 
https://gabrieltanner.org/blog/grafana-sensor-visualization


![alt text](https://github.com/maltorfer/enviroplus-mqtt-docker/blob/main/grafana_dashboard_multi.png?raw=true)
