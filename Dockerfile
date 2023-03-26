FROM ddsderek/nginxwebui:base

ARG VERSION

RUN wget --no-check-certificate https://gitee.com/cym1102/nginxWebUI/releases/download/$(echo "${VERSION}" | sed 's/v//')/nginxWebUI-$(echo "${VERSION}" | sed 's/v//').jar -O /home/nginxWebUI.jar && \
    chmod -R 755 /home/nginxWebUI.jar
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/home/nginxWebUI"]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
