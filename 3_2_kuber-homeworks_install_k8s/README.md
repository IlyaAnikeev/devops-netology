# Домашнее задание к занятию «Установка Kubernetes»

### Цель задания

Установить кластер K8s.

### Чеклист готовности к домашнему заданию

1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.


### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/).

-----

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

## Дополнительные задания (со звёздочкой)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой необязательные к выполнению и не повлияют на получение зачёта по этому домашнему заданию. 

------
### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl get nodes`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

# Ответ

------

### Задание 2*. Установить HA кластер

Выполнил сразу второе задание, так как оно соответствует первому, но с усложнением.

1. С помощью terraform (https://github.com/IlyaAnikeev/devops-netology/tree/main/3_2_kuber-homeworks_install_k8s/code/terraform) развернул инфраструктуру (3 - master node, 4 - worker node):

![vers](img/1_1.png)

![vers](img/2_1.png)

![vers](img/3_1.png)

2. Развернул k8s-кластер с помощью репозитория Kubespray (https://github.com/IlyaAnikeev/devops-netology/tree/main/3_2_kuber-homeworks_install_k8s/code/kubespray/inventory/mycluster):

![vers](img/4_1.png)

![vers](img/5_1.png)

3. Запустил настроенный playbook (https://github.com/IlyaAnikeev/devops-netology/tree/main/3_2_kuber-homeworks_install_k8s/code/HA) по инструкции, который установил Keeplived и HAproxy с необходимыми параметрами:

![vers](img/6_1.png)

4. IP-адрес 10.0.1.100 принадлежит Keeplived. Ноды имеют статус: master-1 - master, master-2 - backup, master-3 - backup. Остановил службу Keeplived на master-1 и проверил master-2. Статус ноды изменился:

![vers](img/7_1.png)

![vers](img/8_1.png)

5. Остановил службу на второй ноде master-2 и проверил статус третьей ноды master-3

![vers](img/9_1.png)

![vers](img/10_1.png)

6. Кластер HA работает.

7. Инструкция:

```
sudo apt-get update -y
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update -y
sudo apt-get install git pip python3.11 -y

sudo -i
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.11 get-pip.py

# RETURN TO USER
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray/
pip3.11 install -r requirements.txt
python3.11 -m pip install ruamel.yaml

# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.128.0.31 10.128.0.21 10.128.0.24)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3.11 contrib/inventory_builder/inventory.py ${IPS[@]}

# Copy private ssh key to ansible host
scp -i ~/.ssh/yandex yandex yc-user@51.250.10.123:.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa

ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v &


mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
```