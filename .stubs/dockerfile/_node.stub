FROM node:20.11.1-alpine

WORKDIR /app

RUN apk update && \
    apk add git && \
    apk add openssh

RUN npm install -g pnpm

ENV HOST 0.0.0.0
EXPOSE 3000