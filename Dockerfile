FROM alpine:3.3

RUN apk --update upgrade \
  && apk add mosquitto \
  && rm -rf /var/cache/apk/*
