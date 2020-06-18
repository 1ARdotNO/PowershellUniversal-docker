FROM ironmansoftware/universal:latest

#install basic dependencies
RUN apt-get update
RUN apt-get install git zip nano ca-certificates -y
