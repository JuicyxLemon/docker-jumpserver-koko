FROM alpine

WORKDIR /opt

# Base Image
RUN ( sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories ;\ 
      apk update ;\
      apk upgrade ;\
      apk add tzdata ;\
      ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ;\
      echo "Asia/Shanghai" > /etc/timezone ;\
      apk add mysql-client curl ;\
      rm -rf /var/cache/apk/* )

# Koko Binary
COPY koko-1.5.6-linux-amd64.tar.gz /opt/koko.tar.gz
COPY entrypoint.sh /entrypoint.sh
RUN ( mkdir -p /opt/ && cd /opt/ ;\
      tar -xf koko.tar.gz ;\
      rm -f koko.tar.gz ;\
      mv kokodir koko ;\
      chown -R root:root koko ;\
      chmod 755 /entrypoint.sh )

WORKDIR /opt/koko

CMD [ "/entrypoint.sh" ]
