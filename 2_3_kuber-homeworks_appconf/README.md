# Домашнее задание к занятию «Конфигурация приложений»

### Цель задания

В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8s).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым GitHub-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/configuration/secret/) Secret.
2. [Описание](https://kubernetes.io/docs/concepts/configuration/configmap/) ConfigMap.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

------

### Правила приёма работы

1. Домашняя работа оформляется в своём GitHub-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

# Ответ

------

### Задание 1

1. Создал Deployment `task-1-deployment.yaml` приложения, состоящего из контейнеров nginx и multitool. Решил возникшую проблему с помощью ConfigMap `task-1-configmap.yaml`. Демонстрация того, что pod стартовал и оба конейнера работают:

![vers](img/1_1.png)

![vers](img/1_2.png)

2. Сделал простую веб-страницу и подключил её к Nginx с помощью ConfigMap. Также подключил Service `task-1-service.yaml`:

![vers](img/1_3.png)

3. Демонстрация сайта:

![vers](img/1_4.png)

------

### Задание 2

1. Создал Deployment `task-2-deployment.yaml` приложения, состоящего из Nginx.

2. Создал собственную веб-страницу и подключил её как ConfigMap `task-2-configmap.yaml` к приложению.

3. Выпустил самоподписной сертификат SSL. Создал Secret `task-2-secret.yaml` для использования сертификата.

![vers](img/2_1.png)

![vers](img/2_2.png)

4. Создал Ingress `task-2-ingress.yaml` и необходимый Service `task-2-service.yaml`, подключил к нему SSL в вид.

![vers](img/2_3.png)

5. Демонстрация доступа к приложению по HTTPS:

![vers](img/2_4.png)

![vers](img/2_5.png)

![vers](img/2_6.png)