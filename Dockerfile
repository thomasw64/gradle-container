# FROM icr.io/appcafe/ibm-semeru-runtimes:open-17-jdk-ubi
FROM icr.io/appcafe/ibm-semeru-runtimes:open-17-jdk-ubi-minimal

ARG GRADLEZIP=gradle-9.0.0-bin.zip

USER root
RUN set -o errexit ; \
    microdnf install -y make findutils unzip which git git-lfs nano ; \
    microdnf clean all
ADD --chmod=644 https://services.gradle.org/distributions/$GRADLEZIP /opt
WORKDIR /opt
ENV PATH="/opt/gradle-9.0.0/bin:$PATH" \
    GRADLE_HOME="/opt/gradle-9.0.0"
RUN unzip $GRADLEZIP; \
    rm $GRADLEZIP; \
    chown -R 1001 $GRADLE_HOME ; \
    mkdir /project; \
    chown 1001 /project; 
WORKDIR /project
