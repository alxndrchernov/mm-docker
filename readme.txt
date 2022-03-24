Если возникли проблемы с виртуальной машиной (непингуется)

cd etc/sysconfig/network-scripts
vi ifconfig-enp0s3
onboot = yes

Пример основной настройки в .env.example
Скопировать и создать файл .env

## Запуск docker-compose

Для запуска использовать команду

docker-compose up -d


Остановка контейнеров

docker-compose down

При внесении изменений в файлы, пересобрать все с помощью:

docker-compose up -d --no-deps --build
