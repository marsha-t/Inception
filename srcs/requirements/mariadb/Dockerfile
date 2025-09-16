FROM debian:bullseye

USER root

RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client

COPY ./requirements/mariadb/tools/docker_entry.sh /usr/local/bin/docker_entry.sh

RUN chmod +x /usr/local/bin/docker_entry.sh

ENTRYPOINT ["docker_entry.sh"]
