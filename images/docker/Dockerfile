FROM postgres:10.5

LABEL maintainer="Alexander Mustafin <mustafin.aleksandr@gmail.com>"

ENV APP postgresql
ENV HOME /var/lib/$APP

ENV POSTGRES_VERSION 10
ENV POSTGRES_HOST 0.0.0.0
ENV POSTGRES_PORT 5432
ENV POSTGRES_DATA /var/lib/postgresql/10/main
ENV POSTGRES_USER postgres
ENV POSTGRES_CONFIG /etc/postgresql/10/main/postgresql.conf
ENV POSTGRES_INITDB_ARGS --encoding=UTF8

#Set flag which we can use in further checking
ENV INIT false

COPY build.sh /tmp/build.sh
RUN /tmp/build.sh

#Set working directory
WORKDIR $HOME

# Expose a volume with configuration
VOLUME ["$HOME"]

SHELL ["/bin/bash", "-lc"]

#COPY entrypoint /

#ENTRYPOINT ["/dumb-init", "--"]
#CMD ["/entrypoint"]
