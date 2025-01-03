
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- хранит загруженные файлы в бакете images,
- S3 протокол,

**uploader**
- принимает файл, если картинка сжимает и загружает его в minio,
- POST /v1/upload,

**security**
- регистрация пользователя POST /v1/user,
- получение информации о пользователе GET /v1/user,
- логин пользователя POST /v1/token,
- проверка токена GET /v1/token/validation.

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/user.

**POST /v1/token**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/token.

**GET /v1/user**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис security GET /v1/user.

**POST /v1/upload**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис uploader POST /v1/upload.

**GET /v1/user/{image}**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис minio GET /images/{image}.

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

# Ответ

## Задача 1: API Gateway 

Для обеспечения реализации API Gateway я предлагаю использовать Nginx Plus. Nginx является популярным веб-сервером и прокси-сервером, который часто используется для балансировки нагрузки и маршрутизации трафика. Nginx Plus предлагает дополнительные возможности, включая поддержку SSL/TLS (что позволяет обеспечить терминацию HTTPS), а также различные механизмы для обработки и маршрутизации HTTP-запросов.

Ниже представлена сравнительная таблица возможностей различных программных решений для API Gateway:

| Решение                | Маршрутизация запросов | Проверка аутентификации  | Терминация HTTPS |
|------------------------|------------------------|--------------------------|------------------|
| Nginx Plus             | Да                     | Да                       | Да               |
| Apache Traffic Server  | Да                     | Да                       | Да               |
| HAProxy                | Да                     | Да                       | Да               |
| Kong                   | Да                     | Да                       | Да               |
| AWS API Gateway        | Да                     | Да                       | Да               |
| Azure API Management   | Да                     | Да                       | Да               |
| Google Cloud Endpoints | Да                     | Да                       | Да               |
| OpenResty              | Да                     | Да                       | Да               |

Из таблицы видно, что большинство решений поддерживают все необходимые функции. Однако, учитывая популярность и гибкость настройки Nginx, а также его широкое использование в индустрии, я бы рекомендовал выбрать именно Nginx Plus для реализации API Gateway. Кроме того, Nginx Plus предлагает коммерческую поддержку и дополнительные функции, которые могут быть полезны в зависимости от конкретных требований проекта.

## Задача 2: Брокер сообщений

Ниже представлена таблица, сравнивающая возможности различных брокеров сообщений. Значения в столбцах отражают наличие или отсутствие соответствующей функциональности у каждого брокера:

| Брокер сообщений  | Кластеризация | Хранение на диске | Высокая скорость | Поддержка форматов сообщений  | Разделение прав доступа | Простота эксплуатации |
|-------------------|---------------|-------------------|------------------|-------------------------------|-------------------------|-----------------------|
| Apache Kafka      | Да            | Да                | Да               | Да                            | Да                      | Да                    |
| RabbitMQ          | Да            | Да                | Да               | Да                            | Да                      | Да                    |
| ActiveMQ          | Да            | Да                | Да               | Да                            | Да                      | Да                    |
| Redis             | Нет           | Нет               | Да               | Да                            | Нет                     | Да                    |
| Beanstalk         | Да            | Да                | Да               | Да                            | Да                      | Да                    |

На основе данных таблицы можно сделать следующие выводы:
- Apache Kafka - это отличный выбор, если требуется высокая производительность и поддержка кластеризации. Он хорошо подходит для систем, где важна обработка больших объемов данных в реальном времени.
- RabbitMQ - хороший выбор для проектов, требующих высокой скорости и простоты эксплуатации. Он также поддерживает кластеризацию и разделение прав доступа.
- ActiveMQ - обладает схожими возможностями с RabbitMQ, но может быть менее предпочтителен из-за меньшей популярности и сообщества.
- Redis - хотя он быстрый и простой в использовании, он не поддерживает кластеризацию и не предназначен для долгосрочного хранения сообщений.
- Beanstalk - поддерживает кластеризацию и разделение прав доступа, но его производительность может быть ниже, чем у вышеупомянутых брокеров.

На мой взгляд, наиболее подходящим выбором будет Apache Kafka, так как он лучше всего соответствует всем требованиям, включая высокую скорость работы, поддержку кластеризации, хранение сообщений на диске, поддержку различных форматов сообщений, разделение прав доступа и простоту эксплуатации.

## Задача 3: API Gateway * (необязательная)

![vers](img/1.png)

![vers](img/2.png)

![vers](img/3.png)

![vers](img/4.png)

Ссылка на код: https://github.com/IlyaAnikeev/devops-netology/tree/main/11-microservices-02-principles_homework/code
