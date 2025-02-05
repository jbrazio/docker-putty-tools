FROM alpine:3.21

LABEL org.opencontainers.image.authors="jbrazio"
LABEL org.opencontainers.image.description="PuTTY tools on a container"
LABEL org.opencontainers.image.licenses=GPL-3.0-or-later
LABEL org.opencontainers.image.source=https://github.com/jbrazio/github-runner-debian.git

# add a standard account
RUN apk add --no-cache bash putty \
  && adduser -Ds /usr/sbin/nologin alpine \ 
  && mkdir /data \
  && chown -R alpine:alpine /data

RUN cat >> /docker-entrypoint.sh <<EOF
#!/bin/bash
echo "Searching for .ppk files.."
for PPK in /data/*.ppk; do
    base_filename=\$(basename "\${PPK}" .ppk)
    echo  " - Found \${base_filename}.ppk.."
    puttygen "\${PPK}" -O private-openssh -o "/data/\${base_filename}_openssh"
done
EOF

RUN chmod +x /docker-entrypoint.sh

USER alpine
CMD ["/docker-entrypoint.sh"]
