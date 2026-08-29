# VPC e subnet publica vem do repositorio oficina-mecanica-infra-db, localizadas por tag
# (nao por remote state) para manter os repositorios desacoplados - ver ADR 0002.

data "aws_vpc" "shared" {
  filter {
    name   = "tag:Project"
    values = [var.project_name]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Project"
    values = [var.project_name]
  }

  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
