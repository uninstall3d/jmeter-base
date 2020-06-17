FROM alpine:3.12.0
MAINTAINER mail@miguelmartens.com

ENV JMETER_VERSION 5.3
ENV JDK_VERSION openjdk8-jre
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV BINARIES_URL https://downloads.apache.org/jmeter/binaries
ENV PATH $PATH:$JMETER_BIN

RUN apk add --no-cache ${JDK_VERSION} curl unzip \
    && curl -L -s -S -o apache-jmeter-${JMETER_VERSION}.tgz ${BINARIES_URL}/apache-jmeter-${JMETER_VERSION}.tgz \
    && curl -L -s -S -o apache-jmeter-${JMETER_VERSION}.tgz.sha512 ${BINARIES_URL}/apache-jmeter-${JMETER_VERSION}.tgz.sha512 \
    && sha512sum -c apache-jmeter-${JMETER_VERSION}.tgz.sha512 \
    && mkdir -p /opt \
    && tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm apache-jmeter-${JMETER_VERSION}.tgz \
    && rm apache-jmeter-${JMETER_VERSION}.tgz.sha512 \
    && apk del curl unzip

WORKDIR ${JMETER_HOME}
ENTRYPOINT ["jmeter"]
CMD ["-h"]
