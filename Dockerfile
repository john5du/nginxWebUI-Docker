FROM ddsderek/nginxwebui:base

ARG VERSION

RUN wget --no-check-certificate http://file.nginxwebui.cn/nginxWebUI-$(echo "${VERSION}" | sed 's/v//').jar -O /home/nginxWebUI.jar && \
    chmod -R 755 /home/nginxWebUI.jar
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/home/nginxWebUI"]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
