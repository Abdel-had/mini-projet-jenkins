# Étape 1 : Cloner le dépôt Git
FROM ubuntu:latest AS clone_stage
RUN apt-get update -y
RUN apt-get install -y git
RUN git clone git@github.com:diranetafen/static-website-example.git /projet

# Étape 2 : Copier le code source dans une nouvelle image légère
FROM httpd:2.4 AS final_stage
LABEL org.opencontainers.image.authors="Abdel-had HANAMI hanami.abdel.had@gmail.com"
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf ./*
COPY --from=clone_stage /projet/ .
EXPOSE 80