#!/bin/bash

export ANSIBLE_VAULT_PASSWORD_FILE=password_file

declare -A image

image["ubuntu"]="pycontribs/ubuntu"
image["centos7"]="centos:7"
image["fedora"]="pycontribs/fedora"

for container in ${!image[@]}
  do
    echo -e "*** Остановка docker-контейнера \"${container}\" ***"
    if docker container stop ${container} > /dev/null
      then
        echo -e "*** Выполнено ***\n"
      else
        echo -e "*** Запущенные docker-контейнеры отсутствуют -> Приступаем к запуску ***\n"
    fi
  done

for container in ${!image[@]}
  do
    echo -e "*** Запуск docker-контейнера \"${container}\" ***"
    if docker run -itd --rm --name ${container} ${image[${container}]} > /dev/null
      then
        echo -e "*** Выполнено ***\n"
      else
        echo -e "*** Ошибка при запуске docker-контейнера -> Выход ***\n"
        exit 1
    fi
  done


if cd /home/ilya/ansible/playbook
  then
    echo -e "\n*** Запуск ansible-playbook ***\n" 
    ansible-playbook -i inventory/prod.yml site.yml
  else
    echo -e "\n*** Ошибка при смене каталога -> Выход ***\n"
    stop_containers
    exit 1
fi

for container in ${!image[@]}
  do
    echo -e "*** Остановка docker-контейнера \"${container}\" ***"
    if docker container stop ${container} > /dev/null
      then
        echo -e "*** Выполнено ***\n"
      else
        echo -e "*** Ошибка при остановке docker-контейнера -> Выход ***\n"
        exit 1
    fi
  done