FROM httpd:2.4 AS final_stage
LABEL org.opencontainers.image.authors="Abdel-had HANAMI hanami.abdel.had@gmail.com"
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf ./*
RUN apt-get update -y && install -y git
RUN git clone git@github.com:diranetafen/static-website-example.git
EXPOSE 80