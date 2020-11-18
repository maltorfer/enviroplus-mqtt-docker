# enviroplus-mqtt-docker
My solution for handling enviroplus air quality sensors using mosquitto, telegraf, influxdb and grafana using docker.

Requirements:
- Host for running Docker containers
- Raspberry PI (I use a zero)
- Enviro+ Sensor https://shop.pimoroni.com/products/enviro
- Optional: Particle Sensor https://shop.pimoroni.com/products/pms5003-particulate-matter-sensor-with-cable

## Install (Server/Docker)
I do use my Synology Storage to run the docker containers. The CPU and memory footprint is marginale if you don't run 100's of sensors.

## Install (Client)
- Follow the steps on https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-enviro-plus to install the required libraries/components
- Copy the contents of the client directory to your raspberry




## References that helped me 
[https://gabrieltanner.org/blog/grafana-sensor-visualization]
