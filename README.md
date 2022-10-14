# homeassistant

## Content
Configuration and other files related to (my) Home Assistant installation. 

### docker-compose.yaml

The docker compose file creates a stack of Linux containers with recent versions of [Home Assistant Container](https://home-assistant.io), [Eclipse Mosquitto](https://mosquitto.org/) and [Zigbee2MQTT](https://www.zigbee2mqtt.io/). The stack is capable of monitoring and controlling any Zigbee device that is supported by [Zigbee2MQTT](https://www.zigbee2mqtt.io/supported-devices/).

A [Zigbee adapter](https://www.zigbee2mqtt.io/guide/adapters/#recommended) is required and must be either connected to the host or available by TCP/IP. 

## Usage

### Configuration

The stack requires configuration by environment variables. Easiest solution is to create a file named `.env` next to the docker compose file. Either way the following environment variables must be defined:

| Name                                    | Purpose | Example |
| -----                                   | ------- | --------|
| SERIAL_DEVICE | path of the Zigbee adapter serial device | /dev/serial/by-id/usb-...-if00-port0 |
| TZ                                      | Local timezone | Europe/Berlin |
| ZIGBEE2MQTT_CONFIG_ADVANCED_NETWORK_KEY | Zigbee network key | [ 1, 3, 5, 7, 9, 11, 13, 15, 0, 2, 4, 6, 8, 10, 12, 13 ] |

Hint: On Linux, you can create the following command to create a new, random network key: `shuf -i0-255 -n16 | paste -sd ','`. Changing the network key requires re-pairing of all Zigbee devices!

### Check

Run the following command to check the docker compose file. This includes environment variable replacement:

    docker compose config
    

### Run

Run the following command to start the stack, detaching the created containers in the background.

    docker compose up -d
    
For testing and debugging purposes, it is also possible to ommit the `-d` argument. 

## Security

The software stack does focus on ease-of-use and is designed to run in a controlled, secured environment. No transport layer security, authentication or encryption is in-place. 
