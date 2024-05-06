
# Домашнее задание к занятию «Микросервисы: масштабирование»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: Кластеризация

Предложите решение для обеспечения развёртывания, запуска и управления приложениями.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- поддержка контейнеров;
- обеспечивать обнаружение сервисов и маршрутизацию запросов;
- обеспечивать возможность горизонтального масштабирования;
- обеспечивать возможность автоматического масштабирования;
- обеспечивать явное разделение ресурсов, доступных извне и внутри системы;
- обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т. п.

Обоснуйте свой выбор.

## Задача 2: Распределённый кеш * (необязательная)

Разработчикам вашей компании понадобился распределённый кеш для организации хранения временной информации по сессиям пользователей.
Вам необходимо построить Redis Cluster, состоящий из трёх шард с тремя репликами.

### Схема:

![11-04-01](https://user-images.githubusercontent.com/1122523/114282923-9b16f900-9a4f-11eb-80aa-61ed09725760.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

# Ответ

## Задача 1: Кластеризация

Для решения поставленной задачи можно использовать комбинацию следующих технологий и инструментов:

1. Kubernetes (или другая система оркестрации контейнеров) - для развертывания, масштабирования и управления контейнерами приложений. Kubernetes поддерживает контейнеры Docker и поддерживает все необходимые требования, включая горизонтальное масштабирование, автоматическое масштабирование и управление ресурсами.
2. Consul от HashiCorp (или другой сервис обнаружения и маршрутизации) - для обнаружения сервисов и маршрутизации запросов между ними. Consul позволяет легко находить сервисы и управлять их жизненным циклом.
3. Vault от HashiCorp (или другой инструмент для управления секретами) - для безопасного хранения чувствительных данных, таких как пароли, ключи доступа и ключи шифрования. Vault предоставляет централизованное хранилище для секретов и позволяет управлять доступом к ним.
4. Terraform от HashiCorp (или другой инструмент для инфраструктуры как код) - для автоматизации развертывания и управления инфраструктурой. Terraform позволяет создавать, изменять и удалять инфраструктуру с помощью кода.
5. Helm (или другой менеджер пакетов для Kubernetes) - для упрощения процесса развертывания приложений в Kubernetes. Helm позволяет устанавливать, обновлять и управлять приложениями как пакетами.
6. Prometheus и Grafana (или другие инструменты мониторинга и визуализации) - для мониторинга и анализа производительности приложений и кластера Kubernetes.

Все эти инструменты могут взаимодействовать друг с другом через API и стандартные протоколы, такие как HTTP, что позволяет создать гибкую и масштабируемую систему для развертывания, запуска и управления приложениями.

## Задача 2: Распределённый кеш * (необязательная)

Для построения Redis Cluster, состоящего из трех шардов с тремя репликами, нам потребуется сделать следующее:

1. Три виртуальных машины, каждая из которых будет работать как отдельный шард в кластере.
2. На каждой VM должно быть установлено соответствующее программное обеспечение Redis.
3. Каждый шард должен иметь свою реплику для обеспечения отказоустойчивости. Всего потребуется три реплики.
4. Каждая реплика должна быть синхронизирована со своим основным шардом и готова взять на себя его роль в случае отказа основного узла.