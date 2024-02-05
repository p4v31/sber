# Prerequirments
Я использовал 2 ВМ:
- sber1: куда установил ansible и через котороую запускал playbook(производит установку Docker, Minikube, kubectl, helm)
- sber2: на которой и происходил весь движ.

Чтобы это работало на другой конфигурации, то нужно:
1. Перейти в папку ansible и в ansible.cfg изменить remote_user на нужного, в inventory.ini изменить под себя iP.
2. Запустить скрипт impreparehost.sh, который установит все необходимое на хосте, откуда будем запускать Ansible.
3. Обменяться ssh ключами с другим хостом.
3.1 Сгенерируем ключ
```
ssh-keygen
```
3.2 перкинем на сервер
```
ssh-copy-id имя_пользователя_на_удаленной_машине@ip_сервера
```
4. Проверим работу Ansible
```
ansible all -i inventory.ini -m ping
```
5. Запускаем playbook
```
ansible-playbook -i inventory.ini  playbook.yml --ask-become-pass
```

# Localhost instead 2 VM
Если нет 2 ВМ, то меняем можно поменять playbook на localhost. 

# Получаем пароль для Jenkins (Ура, мы установили все автоматом, теперь время ручного труда...)
Наш playbook доводит все до состояния того, что у нас разворачивается Jenkins, однако мы не знаем его пароль:)

Для этого сделаем на хосте, где у нас Minikube:
1. Получим поды в пространстве имен devops-tools
```
kubectl get pods --namespace=devops-tools
```
2. Выведем пароль через exec
```
kubectl exec -it <здесь ваш под> cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
```
3. Переходим в Web. С помощью ```ip a``` мы увидим соответвующий iP и перейдем по нему в браузере с портом 32000, введем пароль, установим рекомендуемые плагины и создадим админскую учетку.

# Создаем задачу
Для этого:
1. Нажимаем на + New Item
2. Присваиваем ему имя и выбираем тип Pipeline
3. Переходим в Pipeline и выбираем в Definition Pipeline script from SCM, выбираем SCM Git и в Repository URL вставляем подготовленный мною репозиторий, а также указываем ветку */main.
```

```
4.  Готово!

# Раскатка
Теперь можем в Dashboard увидеть нашу задачу и запустить ее.

Остается лишь перейти в по адресу <ip_как_вы_зашли_в_дженкинс>:32080 и сможем увидеть hello world от Nginx.



