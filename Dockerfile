FROM debian:latest
ENV psuversion 1.4.7

ADD https://imsreleases.blob.core.windows.net/universal/production/${psuversion}/Universal.linux-x64.${psuversion}.zip /tmp/

#install basic dependencies
RUN apt-get update
RUN apt-get install git zip nano ca-certificates wget curl -y

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
RUN unzip /tmp/Universal.linux-x64.${psuversion}.zip -d /home/Universal; exit 0
RUN rm /tmp/Universal.linux-x64.${psuversion}.zip
RUN chmod +x /home/Universal/Universal.Server

#install proxmox-backup-client
RUN echo "deb http://download.proxmox.com/debian/pbs buster pbstest" > /etc/apt/sources.list.d/pbstest-beta.list
RUN wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
RUN apt-get update
RUN apt-get install proxmox-backup-client -y



EXPOSE 5000

CMD [ "/home/Universal/Universal.Server" ]
