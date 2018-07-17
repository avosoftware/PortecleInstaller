FROM ubuntu:latest
RUN mkdir -p portecle-installer/portecle
WORKDIR portecle-installer/

VOLUME /portecle-installer/portecle
VOLUME /portecle-installer/resources

RUN apt-get update && apt-get install -y \
    curl \
    software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo "yes" | apt-get install -y \
    oracle-java8-set-default

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
    lib32z1 \
    lib32ncurses5 \
    libbz2-1.0:i386

ARG NSIS_VERSION=2.51-1
RUN apt-get update && apt-get install -y \
    nsis=$NSIS_VERSION

RUN rm -rf /var/lib/apt/lists/*

ARG LAUNCH4J_VERSION=3.12
RUN curl -J -L https://sourceforge.net/projects/launch4j/files/launch4j-3/$LAUNCH4J_VERSION/launch4j-$LAUNCH4J_VERSION-linux-x64.tgz/download -o launch4j.tgz && \
    tar xf launch4j.tgz && rm launch4j.tgz

ENV VERSION ""
CMD /portecle-installer/resources/build.sh $VERSION