# Как поднять

## Шаг 1
Добавить в `/etc/hosts` хосты для дашборда и тестоых приложений
```
127.0.0.1 traefik.traefik.me
127.0.0.1 nginx_client.traefik.me
```
Расшифровка доменных имен
- `traefik.traefik.me` - доменное имя для дашорда traefik
- `nginx_client.traefik.me` - доменное имя для контейнера nginx через traefik

## Шаг 2
Сгенерировать ssl сертификат одним из способов
- `make download-traefik-me-certs` - скачать с traefic.me
- `make generate-ssl` - сгенерировать с помощью openssl, далее можно добавить в доверенные
  - `make trust-cert` - `[только для MacOS]` добавить сгенерированный сертификат в доверенные

## Шаг 3
`make up` - запустить контейнеры

## Шаг 4
Смотреть в браузере
- https://nginx_client.traefik.me  - приложение по http
- https://traefik.traefik.me - дашборд по https

Обратить внимание что
- http://nginx_client.traefik.me - приложение по http не доступно
- http://traefik.traefik.me - дашборд по http не доступен

## Мат
Эмоции...
