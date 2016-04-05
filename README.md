MuleSoft API Gateway Docker Image (with temporary license for development)
===============

This project contains a Dockerfile for the deployment and packaging of a MuleSoft API Gateway with Docker.

Preparing the Docker base image
---------------

Step one is to manually download the API Gateway from MuleSoft. [MuleSoft API Gateway](https://www.mulesoft.com/ty/dl/api-gateway)
Unzip and change the name of the directory to api-gatway

Due to MuleSoft licensing restrictions, the Docker image only provides a 30 day license. This trusted repo can be adapted to run a licensed version. Use the
last run statement in this README and insert the liceense file into the conf directory on the Docker host. 

Step two is to setup an Anypoint Studio account. You will need it for the license. 
After setting up the account go to the settings page and get you client.id and secret. 
Next change the wrapper.conf to include the following two lines (insert the client id and secret from Anypoint settings)

bash```
wrapper.java.additional.<n>=-Danypoint.platform.client_id=<your client id>
wrapper.java.additional.<n>=-Danypoint.platform.client_secret=<your client secret>
```

For Dev puporses only!
--------------
If the license is expired, download the api-gateway from the link above, destroy the old image on your local environment, and rebuild the image with the docker build command below
```bash
docker rm api-gatway
docker rmi -f granthbr/api-gateway
```
See docker build line in next block

Building and tagging the Docker base image
---------------

```bash
docker build -t granthbr/api-gateway .
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
docker run -it -h oauth2-mock.cloudhub.io --name api-gateway \
-p 8083:8083  -p 8081:8081 -p 8082:8082 \
-v $PWD/apps:/opt/api-gateway/apps \
-v $PWD/domains:/opt/api-gateway/domains \
-v $PWD/logs:/opt/api-gateway/logs \
-v $PWD/policies:/opt/api-gateway/policies \
 granthbr/api-gateway 
```
The previous run command will start the api gateway in interactive mode so that the log is actively deployed as the application runs. 
The log wil only display the Mule log, not the individual application logs. They are not set to merge. The developer has two options: one, mount the logs directory and tail individual logs from that directory. Two, change the wrapper config file to merge the application logs with the Mule log. 

Best way to deploy APIs and applications is to exteranlly mount the apps directory and insert the zip there. 

Another item of interest. THe conf directory can be externally mounted with specific cloudhub client/secret settings to link with the MuleSoft hosted environment. More detailed instructions are available on the MuleSoft documentation page for CloudHub (Google is your friend. :) ). Happy to resolve issues and accept collaborators if anyone is interested. 

