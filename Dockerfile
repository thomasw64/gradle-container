#    MIT License
#
#    Copyright (c) 2025 IBM, Author: Thomas Weinzettl
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in all
#    copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#    SOFTWARE.

FROM icr.io/appcafe/ibm-semeru-runtimes:open-17-jdk-ubi-minimal

USER root

RUN set -o errexit ; \
    microdnf install -y make findutils unzip which git git-lfs nano ; \
    microdnf clean all ;

ARG GRADLEVERSION=9.0.0 
ARG GRADLEZIP=gradle-$GRADLEVERSION-bin.zip \
    GRADLEURL=https://services.gradle.org/distributions

RUN set -o errexit ; \
    groupadd --system --gid 1001 gradle ; \
    useradd --system --gid gradle --uid 1001 --shell /bin/bash gradle ; \
    mkdir -p /home/gradle/.gradle ; \
    chown --recursive gradle:gradle /home/gradle ; \
    chmod --recursive o+rwx /home/gradle ; \
    mkdir /project; \
    chown -R gradle /project; \
    ln --symbolic /home/gradle/.gradle /root/.gradle ; \
    ln --symbolic /home/gradle/.gradle /project/.gradle ;

VOLUME /home/gradle/.gradle

ADD --chmod=644 $GRADLEURL/$GRADLEZIP /opt

WORKDIR /opt

ENV PATH="/opt/gradle-$GRADLEVERSION/bin:$PATH" \
    GRADLE_HOME="/opt/gradle-$GRADLEVERSION"

RUN unzip "$GRADLEZIP"; \
    rm "$GRADLEZIP"; \
    chown -R gradle $GRADLE_HOME ; \
    ln --symbolic $GRADLE_HOME/bin/gradle /usr/bin/gradle ; 

USER gradle
ENV PATH="/opt/gradle-$GRADLEVERSION/bin:$PATH" \
    GRADLE_HOME="/opt/gradle-$GRADLEVERSION" \
    JAVA_HOME=/opt/java/openjdk

WORKDIR /home/gradle
RUN gradle --version

VOLUME /project
# USER root
WORKDIR /project
