# Homeassistant

## Purpose 

Configuration and other files to create a new Home Assistant installation, using Zigbee2MQTT (and Eclipse Mosquitto) to monitor and control Zigbee devices. To run, you need a suitable hardware platform (x86 and arm will do) and a Zigbee adapter attached to it. See Zigbee2MQTT's [recommended adapters](https://www.zigbee2mqtt.io/guide/adapters/#recommended) for suitable devices.

## Usage

1. Clone this repository to a suitable machine and change into the created directory `homeassistant`.
1. Create an `.env` file in that directory with the environment variable names and values specified below
1. Use `docker compose config` to validate the compose file and variable substitution
1. Use `docker compose up -d` to start the stack
1. After some time, open a browser and point it to http://<hostname or -ip>:80/ to open Home Assistant UI and start onboarding
1. at the last step of the onboarding dialog, click on the MQTT symbol to configure the connection to mosquitto ([screenshot](./onboarding-summary.png))
1. in the modal subdialog, simply enter `mosquitto` as MQTT server name and submit ([screenshot](./mqtt-config-dialog.png))



### Configuration

The stack requires configuration by environment variables. Easiest solution is to create a file named `.env` next to the docker compose file. See Docker's [documentation](https://docs.docker.com/compose/environment-variables/#the-env-file) on .env-files for details.

Either way the following environment variables must be defined:

| Name                                    | Purpose | Example |
| -----                                   | ------- | --------|
| SERIAL_DEVICE | Path of the Zigbee adapter serial device | /dev/serial/by-id/usb-...-if00-port0 |
| TZ                                      | Local timezone | Europe/Berlin |
| ZIGBEE2MQTT_CONFIG_ADVANCED_NETWORK_KEY | Zigbee network key as array of bytes (decimal notation)| [ 1, 3, 5, 7, 9, 11, 13, 15, 0, 2, 4, 6, 8, 10, 12, 13 ] |

Hint: On Linux, you can create the following command to create a new, random network key: `shuf -i0-255 -n16 | paste -sd ','`. **Changing the network key requires re-pairing of all Zigbee devices!**

## Notes

* the Home Assistant UI is mapped to port 80 on the host, no proxy is in-place
* the Home Assistant container is not using the host's network, discovery of integrations in Home Assistant will not work.
* the Zigbee2MQTT frontend is disabled
* the Mosquitto MQTT service is attached to the stack's internal network only

### Security

The project focusses on ease-of-use and does not provide any additional security measures. Use in a secure, controlled environment only.
