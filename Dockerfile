FROM maven:3-jdk-8

MAINTAINER andreas.waelchli@me.com

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV appdir /usr/src/app/
ENV rm -rf /usr/src/app/
RUN mkdir -p $appdir
WORKDIR $appdir

# Combine RUN apt-get update with apt-get install in the same RUN statement to avoid caching issues (https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
RUN apt-get update && apt-get install -y git build-essential
RUN apt-get clean

COPY startup_container.sh startup.sh

RUN ["chmod", "+x", "/usr/src/app/startup.sh"]

EXPOSE 8080

# Drop privileges according to Docker and Best Practices (https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md)
#USER node

# Start the node server
ENTRYPOINT ["/usr/src/app/startup.sh"]
