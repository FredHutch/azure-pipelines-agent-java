FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    METADATA_FILE=/image/metadata.txt \
    HELPER_SCRIPTS=/scripts/helpers

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes && \
    mkdir /image && \ 
    mkdir agent && \
    touch /image/metadata.txt

COPY scripts /scripts
COPY jdk-8u231-linux-x64.tar.gz /tmp/jdk.tar.gz

RUN apt-get update && \
    apt-get install \
    apt-utils \
    lsb-release \ 
    lsb-core \
    software-properties-common \
    apt-transport-https

RUN /scripts/preparemetadata.sh && \
    /scripts/installers/basic.sh && \
    /scripts/ms-repos.sh && \
    /scripts/helpers/apt.sh && \
    # /scripts/installers/azcopy.sh && \
    # /scripts/installers/azure-cli.sh && \
    /scripts/installers/node.sh && \
    /scripts/installers/java.sh 

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh


CMD ["/bin/sh", "-c", \
    "AZP_URL=`cat /run/secrets/HUTCHBASE_BUILD_AZP_URL` \
    AZP_TOKEN=`cat /run/secrets/HUTCHBASE_BUILD_AZP_TOKEN` \
    AZP_AGENT_NAME=`cat /run/secrets/HUTCHBASE_BUILD_AZP_AGENT_NAME` \
    ./start.sh"]