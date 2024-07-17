# -*- mode: ruby -*-
# vi: set ft=ruby :

TERRAFORM_VERSION = "1.9.2"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    # Actualizar repositorios e instalar dependencias
    sudo apt-get update
    sudo apt-get install -y unzip wget software-properties-common

    # Instalar Terraform
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    # Instalar Ansible
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible

    #Crear carpeta de proyecto
    mkdir /vagrant/Proyecto

    # Verificar las instalaciones
    terraform --version
    ansible --version
  SHELL
end