FROM alpine:latest

MAINTAINER Raja Beemi <beemi.raja@gmail.com>

ARG GATLING_VERSION="3.6.1"

ENV SIMULATION_NAME $SIMULATION_NAME

ENV GATLING_HOME /gatling
ENV GATLING_BIN $GATLING_HOME/bin
ENV GATLING_CONF $GATLING_HOME/conf
ENV GATLING_SIMULATION $GATLING_HOME/user-files/simulations
ENV GATLING_RESOURCES $GATLING_HOME/user-files/resources
ENV GATLING_RESULTS_DIR $GATLING_HOME/results

# Install some library's
RUN apk update \
    && apk add --no-cache wget \
    && apk add --no-cache zip \
    && apk add --no-cache openjdk8 \
    && apk add --no-cache curl git python3 py3-pip groff \
    && pip3 install --upgrade pip \
    && pip3 install awscli \
    && rm -rf /var/cache/apk/* \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.7/bin/linux/amd64/kubectl \
    && chmod u+x kubectl \
    && mv kubectl /bin/kubectl

RUN echo 'Installing Gatling'
RUN wget "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip" -O gatling.zip && \
    unzip gatling.zip && \
    rm gatling.zip && \
    mv gatling-charts-highcharts-bundle-$GATLING_VERSION $GATLING_HOME/

WORKDIR $GATLING_BIN

ADD src/gatling/resources/* $GATLING_CONF/
ADD src/gatling/scala/com.meek.ventures* $GATLING_SIMULATION/

ADD ./*.sh $GATLING_BIN/

WORKDIR $GATLING_BIN

ENTRYPOINT ["sh", "/gatling/bin/entrypoint.sh"]

