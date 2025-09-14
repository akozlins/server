#

```yaml
  miniflux:
    << : *service
    image: "miniflux/miniflux"
    depends_on: [ "rss_db" ]
    environment:
      - "ADMIN_PASSWORD=${MINIFLUX_PASSWORD:?}"
      - "ADMIN_USERNAME=admin"
      - "BASE_URL=https://${DOMAIN:?}/miniflux/"
      - "CREATE_ADMIN=1"
      - "DATABASE_URL=postgres://${DB_USER:?}:${DB_PASSWORD:?}@db/db?sslmode=disable"
      - "RUN_MIGRATIONS=1"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.miniflux.rule=PathPrefix(`/miniflux/`)"
      - "traefik.http.services.miniflux.loadbalancer.server.port=8080"
    networks: [ "traefik" ]
```

```yaml
  organice:
    << : *service
    image: "twohundredok/organice"
#    environment:
#      - "ORGANICE_WEBDAV_URL=http://webdav.example.com"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.organice.rule=PathPrefix(`/organice/`)"
      - "traefik.http.services.organice.loadbalancer.server.port=5000"
    networks: [ "traefik" ]
```

```
fcgi-app php-fcgi-app
    log-stderr global
    docroot /var/www/html
    index index.php
    path-info ^(/.+\.php)(/.*)?$

backend php-backend
    use-fcgi-app php-fcgi-app
    server php php:9000 proto fcgi

frontend php-frontend
    bind :8080
    default_backend php-backend
```
