FROM ubuntu:20.04 AS downloads

RUN apt-get update -y
RUN apt-get install wget -y
RUN wget \
        http://file.nginxwebui.cn/nginxWebUI-$(wget --no-check-certificate -qO- https://gitee.com/api/v5/repos/cym1102/nginxWebUI/tags | grep 'name' | cut -d\" -f4).jar \
        -O /nginxWebUI.jar

FROM ddsderek/nginxwebui:base

COPY --from=downloads --chmod=755 /nginxWebUI.jar /home/nginxWebUI.jar
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/home/nginxWebUI"]
ENTRYPOINT ["tini", "entrypoint.sh"]
