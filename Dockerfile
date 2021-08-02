FROM ironmansoftware/universal:latest
LABEL description="Universal - with extra spice added!" 

#install basic dependencies
RUN apt-get update
RUN apt-get install git zip nano ca-certificates wget curl less locales gss-ntlmssp openssh-client -y


#install meshcentral integration dependencies
RUN apt install nodejs
RUN npm install minimist
RUN npm install ws
RUN cd / && wget https://raw.githubusercontent.com/Ylianst/MeshCentral/master/meshctrl.js
