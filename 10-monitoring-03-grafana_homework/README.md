# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы 
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

### Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
1. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
1. Подключите поднятый вами prometheus, как источник данных.
1. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
1. В качестве решения задания приведите листинг этого файла.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---

# Ответ:

## Обязательные задания

### Задание 1

1. Самостоятельно развернул grafana, где в роли источника данных выступает prometheus, а сборщиком данных является node-exporter:

![vers](img/1_1_runing_stack.png)

2. Зашёл в веб-интерфейс grafana (http://localhost:3000/), используя авторизационные данные по умолчанию admin/admin (после ввода пароля - заменил его):

![vers](img/2_1_grafana_run.png)

3. Подключил prometheus, как источник данных:

![vers](img/3_1_add_url_prometheus.png)

![vers](img/3_2_prometheus_save.png)

4. Grafana со списком подключенных Datasource:

![vers](img/4_1_data_sources.png)

### Задание 2

- Создал Dashboard и в ней создал Panels:

  - утилизация CPU для nodeexporter (в процентах, 100-idle) (утилизация CPU для nodeexporter (в процентах, 100-idle): `100 - (avg by (instance) (rate(node_cpu_seconds_total{job="node",mode="idle"}[1m])) * 100)`):

![vers](img/5_1_cpu_idle_100.png)

  - CPULA 1/5/15 (среднее время нагрузки на CPU за последнюю 1 минуту: `avg(node_load1{job="node"})`, среднее время нагрузки на CPU за последние 5 минут: `avg(node_load5{job="node"})`, среднее время нагрузки на CPU за последние 15 минут: `avg(node_load15{job="node"})`):

![vers](img/6_1_cpula_1_5_15.png)

  - количество свободной оперативной памяти (общее количество RAM: `node_memory_MemTotal_bytes`, количество свободной RAM: `node_memory_MemFree_bytes`):

![vers](img/7_1_ram_free.png)

  - количество места на файловой системе (объём доступного пространства: `node_filesystem_avail_bytes`, объём раздела: `node_filesystem_size_bytes`):

![vers](img/8_1_fs.png)

- Dashboard:

![vers](img/9_1_dashboard.png)

### Задание 3

1. Создал для каждой Dashboard подходящее правило alert:

![vers](img/10_1_dashboards_alerts.png)

2. Также настроил alert в telegram на "падение" инстанса:

![vers](img/11_1_prom_alerts.png)

![vers](img/12_1_telegram_ins_down.png)

![vers](img/13_1_dcyml.png)

![vers](img/14_1_promyml.png)

![vers](img/15_1_alertsrule.png)

![vers](img/16_1_confyml.png)

### Задание 4

1. Сохранил Dashboard. Ссылка на файл «JSON MODEL»: https://github.com/IlyaAnikeev/devops-netology/blob/main/10-monitoring-03-grafana_homework/code/dashboard.json
