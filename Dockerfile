# syntax=docker/dockerfile:1
FROM ghcr.io/gohugoio/hugo:v0.170.0 AS build

WORKDIR /project

COPY --chown=hugo:hugo . .

RUN hugo build \
    --minify \
    --baseURL blog.jamesstockton.com

# runtime container
FROM nginxinc/nginx-unprivileged:alpine

COPY --from=build /project/public/ /usr/share/nginx/html/

EXPOSE 8080
