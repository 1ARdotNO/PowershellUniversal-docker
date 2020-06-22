FROM ubuntu:18.04
ENV psuversion 1.2.2

ADD https://imsreleases.blob.core.windows.net/universal/production/${psuversion}/Universal.linux-x64.${psuversion}.zip /tmp/

#install basic dependencies
RUN apt-get update
RUN apt-get install git zip nano ca-certificates -y

# Install powershell 7
RUN \
 apt-get update && \
 apt-get install wget -y && \
 apt-get install software-properties-common -y && \
 wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
 dpkg -i packages-microsoft-prod.deb && \
 apt-get update && \
 add-apt-repository universe && \
 apt-get install -y powershell

#Unzip psu files
RUN mkdir /psubin/
RUN unzip /tmp/Universal.linux-x64.${psuversion}.zip /psubin/
RUN chmod +x /psubin/Universal.Server

#create folder for dashboard files
RUN mkdir /psufiles/

CMD [ "/psubin/Universal.Server" ]
