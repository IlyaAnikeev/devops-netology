# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

---
## Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

Используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к Production like сети Autoscaling group из трёх EC2-инстансов с  автоматической установкой веб-сервера в private домен.

1. Создать бакет S3 и разместить в нём файл с картинкой:

 - Создать бакет в S3 с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать доступным из интернета.
2. Сделать Launch configurations с использованием bootstrap-скрипта с созданием веб-страницы, на которой будет ссылка на картинку в S3. 
3. Загрузить три ЕС2-инстанса и настроить LB с помощью Autoscaling Group.

Resource Terraform:

- [S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Launch Template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template).
- [Autoscaling group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group).
- [Launch configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
```
### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

# Ответ

------

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

- Создал бакет в Object Storage с именем (anikeev-17-07-2024):

![vers](img/1_1.png)

![vers](img/1_2.png)

![vers](img/1_3.png)

- Положил в бакет файл с картинкой `sun.jpg` и с помощью `acl = "public-read"` сделал его доступным из сети интернет:

![vers](img/1_4.png)

![vers](img/1_5.png)

![vers](img/1_6.png)

- С помощью `output` получил адрес загруженного в бакет изображения:

```
output "Picture_URL" {
  value = "https://${yandex_storage_bucket.anikeev.bucket_domain_name}/${yandex_storage_object.picture.key}"
  description = "Адрес загруженного в бакет изображения"
}
```

![vers](img/1_7.png)

2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

- Создал Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP использовал `image_id = fd827b91d99psvq5fjit`:

![vers](img/2_1.png)

![vers](img/2_2.png)

- Для создания стартовой веб-страницы использовал раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata). Разместил на стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.:

![vers](img/2_3.png)

- Настроил проверку состояния ВМ:

![vers](img/2_1.png)

![vers](img/2_4.png)

![vers](img/2_5.png)

![vers](img/2_6.png)

![vers](img/2_7.png)

3. Подключить группу к сетевому балансировщику:

- Создал сетевой балансировщик. Балансировщик проверяет доступность порта `80` и пути `"/"`. Проверка будет выполняться с интервалом 10 секунд и таймаутов 5 секунд. Пороговые значение для определения состояния ВМ будут следующими: 3 неудачные попытки для перевода ВМ в недоступное состояние и 5 успешных попыток для перевода ВМ в доступное состояние:

![vers](img/3_1.png)

![vers](img/3_2.png)

![vers](img/3_3.png)

![vers](img/3_4.png)

![vers](img/3_5.png)

- Проверил работоспособность, остановив две ВМ:

![vers](img/3_6.png)

- Сайт продолжает работать, так как доступна 1 ВМ из 3-х:

![vers](img/3_6.png)

![vers](img/3_7.png)

- Через некоторое время, после срабатывания healthcheck, остановленные 2 ВМ были преведены в состояние running:

![vers](img/3_8.png)

4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

- Создал alb target group:

![vers](img/4_1.png)

- Создал alb backend group:

![vers](img/4_2.png)

![vers](img/4_3.png)

- Создал http-роутер и виртуальный хост:

![vers](img/4_4.png)

![vers](img/4_5.png)

- Создал L7-балансировщик:

![vers](img/4_6.png)

- Проверил созданные ресурсы:

![vers](img/4_7.png)

![vers](img/4_8.png)

- Проверяем страницу по внешнему IP-адресу Application Load Balancer, всё работает исправно:

![vers](img/4_9.png)