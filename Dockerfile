FROM postgres:10-alpine
MAINTAINER Jonatan Heyman <http://heyman.info>

# Install dependencies
RUN apk update && apk add --no-cache --virtual .build-deps && apk add \
    bash make curl openssh git py3-six py3-urllib3 py3-colorama

# Install aws-cli
RUN apk -Uuv add groff less python3 py3-pip 

RUN pip3 install urllib3 awscli six
# Cleanup
RUN apk --purge -v del py3-pip && rm /var/cache/apk/*

VOLUME ["/data/backups"]

ENV BACKUP_DIR /data/backups

ADD . /backup

ENTRYPOINT ["/backup/entrypoint.sh"]

CMD crond -f -l 2
