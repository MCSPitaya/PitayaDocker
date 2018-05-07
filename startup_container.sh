#!/bin/bash

# Open app directory:
cd /usr/src/app/

# Pull current code base from Github
git init
git remote add origin https://github.com/MCSPitaya/PitayaServer.git
git pull origin master

./mvnw clean install

java -jar target/pitaya*.jar
