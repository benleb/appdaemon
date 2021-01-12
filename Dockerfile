# syntax = docker/dockerfile:experimental

FROM python:3.9-alpine

# API Port
EXPOSE 5050

# Mountpoints for configuration & certificates
VOLUME /conf
VOLUME /certs

# Copy appdaemon into image
WORKDIR /usr/src/app
COPY . .

# Install dependencies
RUN --mount=type=tmpfs,target=/tmp \
    apk add --no-cache curl tzdata && \
    apk add --no-cache g++ gcc libffi-dev libstdc++ openssl-dev musl-dev && \
    pip install --no-cache-dir .

# Start script
ENTRYPOINT ["./dockerStart.sh"]
