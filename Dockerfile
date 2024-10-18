# Dockerfile for deploying Hugo site on Fly.io

FROM klakegg/hugo:ext-alpine AS build
WORKDIR /src
COPY . .
RUN hugo --minify

FROM nginx:alpine
COPY --from=build /src/public /usr/share/nginx/html

