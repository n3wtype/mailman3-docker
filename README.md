# mailman3-docker

The purpose of this Dockerfile is to build mailman3 container.

## Usage

This docker containter could be used in cooperation with postorius-docker ([github](https://github.com/n3wtype/postorius-docker), [dockerhub](https://hub.docker.com/r/newtype87/postorius-docker/)) and with [compose](https://github.com/n3wtype/mailman3-compose).

This image is configured to work with embedded sqlite database which can be put on external volume to achieve data persistence. 

## Expected env variables

* **MAILMAN_REST_API_USER** - user used to authenticate to mailman3 API endpoint (default: restadmin)
* **MAILMAN_REST_API_PASSWORD** - password used to authenticate to mailman3 API endpoint (default: restpass)

* **MAILMAN_SMTP_HOST** - address of smtp server which is relaying messgaes send by mailman (default: none, must be provided)
* **MAILMAN_SMTP_PORT** - tcp port used to connect to relay smtp server (default: 25)
* **MAILMAN_SITE_OWNER** - email address of mailman's instance  (default: admin@HOSTNAME)
