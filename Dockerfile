FROM debian:latest
ENV psuversion 1.4.7

ADD https://imsreleases.blob.core.windows.net/universal/production/${psuversion}/Universal.linux-x64.${psuversion}.zip /tmp/
https://imsreleases.blob.core.windows.net/universal/production/1.4.7/Universal.linux-x64.1.4.7.zip
#install basic dependencies
RUN apt-get update
RUN apt-get install git zip nano ca-certificates -y

# Install powershell 7
RUN \
 apt-get update && \
 apt-get install wget -y && \
 apt-get install software-properties-common -y && \
 wget -q https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb && \
 dpkg -i packages-microsoft-prod.deb && \
 apt-get update && \
 apt-get install -y powershell
 
#Unzip psu files
RUN mkdir /home/Universal
RUN unzip /tmp/Universal.linux-x64.${psuversion}.zip -d /home/Universal | true
RUN rm /tmp/Universal.linux-x64.${psuversion}.zip
RUN chmod +x /home/Universal/Universal.Server

EXPOSE 5000

CMD [ "/home/Universal/Universal.Server" ]
