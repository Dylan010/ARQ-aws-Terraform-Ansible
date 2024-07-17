# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
   vb.memory = "2048"
   vb.cpus = 2
 end

   config.vm.provision "shell", inline: <<-SHELL

# Actualizar repositorios e instalar dependencias
    sudo apt-get update
    sudo apt-get install -y unzip wget

# Instalar Terraform manualmente
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y terraform

# Instalar Ansible (versión disponible en los repositorios de Trusty)
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible

#Crear carpeta de proyecto
    mkdir -p /home/vagrant/Proyecto

# Verificar las instalaciones
    terraform --version
    ansible --version
   SHELL

# Agregar configuración de carpeta compartida
    config.vm.synced_folder "./compartida", "/home/vagrant/Proyecto"
end
