# Как поднять

## Шаг 1
Добавить в `/etc/hosts` хосты для дашборда и тестоых приложений
```
127.0.0.1 traefik.local
127.0.0.1 nginx-client-no-ssl
127.0.0.1 nginx-server-no-ssl
127.0.0.1 balance_localhost_8808_8880.local
```
Расшифровка доменных имен
- `traefik.local` - доменное имя для дашорда traefik
- `nginx-client-no-ssl` - доменное имя для первого контейнера nginx (nginx_client) через traefik
- `nginx-server-no-ssl` - доменное имя для второго контейнера nginx (nginx_server) через traefik
- `balance_localhost_8808_8880.local` - доменное имя для балансировщика (смотри описание ниже)

## Шаг 2
`make up` - запустить контейнеры

## Шаг 3
Смотреть в браузере
- http://traefik.local - дашборд, тут видно как и на каком порту соединяется траефик с контейнерами докера
- http://nginx-client-no-ssl - первый контейнер nginx (nginx_client) через traefik
- http://nginx-server-no-ssl - второй контейнер nginx (nginx_server) через traefik
- http://localhost:8808 - первый контейнер nginx (nginx_client) из открытого порта контейнера, для теста балансировщика
- http://localhost:8880 - второй контейнер nginx (nginx_server) из из открытого порта контейнера, для теста балансировщика
- http://balance_localhost_8808_8880.local - балансировка контейнерами (настроена [тут](.docker/traefik/file_provider/balance_localhost_8808_8880.local.yml))

## Мат
Эмоции...
