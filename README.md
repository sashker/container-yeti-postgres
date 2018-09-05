# Containerized Yeti Postgresql
This project is aimed to provide an opportunity to run Yeti in containerized environments.
Currently we support just a Docker image but later we may build a Rkt image or whatever.

    You can use this imager for testing purposes or even for a production installation but keep
    in mind all downsides of using containers.

#TL;DR
In order to start a postgres instance:

    $ docker run --name yeti-postgres -e POSTGRES_PASSWORD=mysecretpassword -d sashker/container-yeti-postgres:10.5

you'll get a running Docker instance which is exposed on the port 5432, and using a POSTGRESQL_PASSWORD which you defined in the environment variable. And yes, username you can also define in the according environment variable POSTGRESQL_USER (**postgres** by default.)

##Connect from applications
    docker run --name some-app --link yeti-postgres:postgres -d application-that-uses-postgres

##Connect to it via **psql**
    docker run -it --rm --link yeti-postgres:postgres postgres psql -h postgres -U postgres

#Environment variables
They might be important because define behaviour of the container. You can easily look into source code of the container and figure out for what they necessary. We give you some clues anyway.

##POSTGRES_PASSWORD
This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the POSTGRES_USER environment variable. The PostgreSQL image sets up trust authentication locally so you may notice a password is not required when connecting from localhost (inside the same container). However, a password will be required if connecting from a different host/container.

##POSTGRES_USER
This optional environment variable is used in conjunction with POSTGRES_PASSWORD to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of postgres will be used.

##POSTGRES_DATA
It's simple. There all data will be stored. You can change it for any particular reason

#How to do something on the initdb stage
You may put ***.sql**, ***.sql.gz**, or ***.sh** into **/initdb.d** directory and once the initdb stage is completed they will be run.

For example, you can create Yeti's databases and users:
    
    #!/bin/bash
    set -e

    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER yeti encrypted password 'somepassword' superuser;
    CREATE DATABASE yeti OWNER yeti;
    CREATE DATABASE cdr OWNER yeti;
    EOSQL

!!!REMEMBER!!! Don't use default usernames, passwords, or whatever. 

#Recomendations
This image uses a default PostgreSQL config and it's configured to consume as minimum resources as possible. You'd better think about changing parametes by using your own config and settin up parameters like the official Yeti's documentation recommend [[https://yeti-switch.org/docs/en/installation/database-tuning.html]]
