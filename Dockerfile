FROM httpd:2.4
LABEL org.opencontainers.image.authors="Abdel-had HANAMI hanami.abdel.had@gmail.com"
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf ./*
RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get install -y git
EXPOSE 80