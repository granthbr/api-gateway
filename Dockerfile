# Dockerizing MuleSoft Api-Gateway
# Version:  0.1
# Based on:  java (Trusted Java from http://java.com)

FROM                   java
MAINTAINER             Brandon Grantham <brandon.grantham@gmail.com>

# This line can reference either a web url (ADD), network share or local file (COPY)
COPY                    ./api-gateway /opt/api-gateway

# Mule remote debugger
EXPOSE  5000

EXPOSE 8083

EXPOSE 8082


# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Mule MMC agent port
EXPOSE  7777

# Environment and execution:

ENV             MULE_BASE /opt/api-gateway
ENV             mule_base /opt/api-gateway
WORKDIR         /opt/api-gateway
CMD             ./bin/gateway