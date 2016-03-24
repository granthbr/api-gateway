MuleSoft API Gateway Docker Image (with temporary license for development)
===============

This project contains a Dockerfile for the deployment and packaging of a MuleSoft API Gateway with Docker.

Preparing the Docker base image
---------------

Step one is to manually download the API Gateway from MuleSoft. [MuleSoft API Gateway](https://www.mulesoft.com/ty/dl/api-gateway)
Unzip and change the name of the directory to api-gatway

Due to MuleSoft licensing restrictions, the Docker image only provides a 30 day license. This trusted repo can be adapted to run a licensed version. Use the
last run statement in this README and insert the liceense file into the conf directory on the Docker host.  


Building and tagging the Docker base image
---------------

```bash
docker build -t granthbr/api-gateway.
```

Start an MuleSoft Api-Gateway instance

```bash
docker run  -it --name='api-gateway' api-gateway
```

Start in daemon mode:

```bash 
docker run -d --name api-gateway granthbr/api-gateway
```

Or host volumes extenarlly with accessible ports

```bash 
docker run -it -h oauth2-datascan-mock.cloudhub.io --name='api-gateway' -p 8083:8083  -p 8081:8081 -p 8082:8082 \
-v $PWD/apps:/opt/api-gateway/apps \
-v $PWDdomains:/opt/api-gateway/domains \
-v $PWD/conf:/opt/api-gateway/conf \
-v $PWD/logs:/opt/api-gateway/logs \
-v $PWD/policies:/opt/api-gateway/policies \
 granthbr/api-gateway
```