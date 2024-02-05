#!/bin/bash

#Установим Ansible 
sudo apt update
sudo apt -y install openssh-server software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt -y install ansible



