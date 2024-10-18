# Stage 1: Build Hugo site
FROM klakegg/hugo:0.101.0-ext-alpine as builder
#FROM klakegg/hugo:ext-alpine as builder

WORKDIR /src
COPY . /src
RUN hugo --minify --baseURL "https://troposskepsis.fly.dev"

# Stage 2: Serve site with Caddy
FROM caddy:alpine

# Copy the Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the static files from the build stage
COPY --from=builder /src/public /usr/share/caddy

# Expose port 80 (Caddy listens on this by default)
EXPOSE 80

# Start Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

