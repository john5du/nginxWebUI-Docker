FROM ubuntu:20.04 AS build

RUN apt-get update -y
RUN apt-get install wget git -y
RUN git clone https://gitee.com/cym1102/nginxWebUI.git /src
WORKDIR /src
RUN export version=$(cat pom.xml | grep -A1 nginxWebUI | grep version | perl -pe "s|.*((\d+\.?){3,}).*|\1|")
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install maven -y
RUN mvn clean package
RUN echo $version

FROM ddsderek/nginxwebui:base

COPY --from=build --chmod=755 /src/target/nginxWebUI-*.jar /home/nginxWebUI.jar
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/home/nginxWebUI"]
ENTRYPOINT ["tini", "entrypoint.sh"]
