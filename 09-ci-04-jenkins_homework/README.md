# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать две VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---

# Ответ

## Подготовка к выполнению

1. Создал две VM: для jenkins-master и jenkins-agent с помощью [terraform]():

![vers](img/1_1_create_vm.png)

2. Установил Jenkins при помощи playbook:

![vers](img/1_2_playbook.png)

3. Запустил и проверил работоспособность:

![vers](img/1_3_jankins_first_run.png)

4. Сделал первоначальную настройку. Скопировал и ввёл пароль `[centos@jenkins-master ~]$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword`, настроил агент (ssh 51.250.92.8 java -jar /opt/jenkins_agent/agent.jar порт: случайный):

![vers](img/1_4_1_jenkins_setup.png)

![vers](img/1_4_2_jenkins_setup.png)

![vers](img/1_4_3_jenkins_setup.png)

![vers](img/1_4_4_jenkins_setup.png)

![vers](img/1_4_5_jenkins_setup.png)

![vers](img/1_4_6_jenkins_setup.png)

- [centos@jenkins-agent ~]$ curl -sO http://158.160.32.233:8080/jnlpJars/agent.jar
[centos@jenkins-agent ~]$ java -jar agent.jar -jnlpUrl http://158.160.32.233:8080/computer/jenkins%2Dagent/jenkins-agent.jnlp -secret 72ea8982826fcf53247e4ac995fa8f4eea2c7569cbc0326314f351135d1424f0 -workDir "ssh 51.250.92.8 java -jar  /opt/jenkins_agent/agent.jar"

![vers](img/1_4_7_jenkins_setup.png)

![vers](img/1_4_8_jenkins_setup.png)

![vers](img/1_4_9_jenkins_setup.png)

![vers](img/1_4_10_jenkins_setup.png)

## Основная часть

1. Сделал Freestyle Job, который запускает `molecule test` из моего [репозитория с ролью](https://github.com/IlyaAnikeev/vector-role).

![vers](img/1_5_1_freestyle_job.png)

![vers](img/1_5_2_git_repo.png)

- ssh -T git@github.com -> ssh-keyscan -t rsa github.com [GitHub's SSH key fingerprints](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)

![vers](1_5_3_ssh_git.png)

![vers](img/1_5_4_step.png)

- Предоставил права `sudo chmod 777 /var/run/docker.sock`

- Сборка завершена успешно:

![vers](img/1_5_5_freestyle_success.png)

2. Сделал Declarative Pipeline Job, который запускает `molecule test` из моего [репозитория с ролью](https://github.com/IlyaAnikeev/vector-role).

![vers](img/1_6_2_pipeline_script.png)

![vers](img/1_6_3_pipeline_success.png)

![vers](img/1_6_4_stage_view.png)

3. Перенёс Declarative Pipeline в репозиторий в файл [`Jenkinsfile`](https://github.com/IlyaAnikeev/vector-role/blob/main/Jenkinsfile).

4. Создал Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

- Scan Multibranch Pipeline

![vers](img/1_7_1_scan_multi.png)

![vers](img/1_7_2_stage_view.png)

5. Создал Scripted Pipeline, наполнил его скриптом из [pipeline](./pipeline).

![vers](img/1_8_1_node_script.png)

6. Внёс необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.

![vers](img/1_8_2_node_script_change.png)


7. Проверил работоспособность, исправил ошибки, исправленный Pipeline вложил в репозиторий в файл [`ScriptedJenkinsfile`](https://github.com/IlyaAnikeev/devops-netology/blob/main/09-ci-04-jenkins_homework/pipeline/ScriptedJenkinsfile).

![vers](img/1_8_3_script_success.png)

![vers](img/1_8_4_script_stage_view.png)

8. Ссылка на репозиторий с ролью и [Declarative Pipeline](https://github.com/IlyaAnikeev/vector-role/blob/main/Jenkinsfile) и [Scripted Pipeline](https://github.com/IlyaAnikeev/devops-netology/blob/main/09-ci-04-jenkins_homework/pipeline/ScriptedJenkinsfile).




