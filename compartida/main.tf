terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Ajusta la región según tus preferencias
  access_key = ""
  secret_key = ""
}

# Genera un nuevo par de claves
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Crea un key pair de AWS usando la clave pública generada
resource "aws_key_pair" "generated_key" {
  key_name   = "terraform-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Guarda la clave privada en un archivo local
resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/terraform-key.pem"
  file_permission = "0400"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "ubuntu_free_tier" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t2.micro"  # Tipo de instancia elegible para Free Tier
  key_name      = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Ubuntu-Free-Tier"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Permite trafico SSH y HTTP entrante"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.ubuntu_free_tier.public_ip
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}