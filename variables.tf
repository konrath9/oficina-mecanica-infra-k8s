variable "aws_region" {
  description = "Regiao AWS (fixa em us-east-1 no AWS Academy Learner Lab)"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefixo usado no nome/tags de todos os recursos, e chave usada para localizar a VPC do repositorio oficina-mecanica-infra-db via data source"
  type        = string
  default     = "oficina-mecanica"
}

variable "instance_type" {
  description = "Tipo da instancia EC2 que hospeda o k3s"
  type        = string
  default     = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "CIDR autorizado a acessar a porta 22 (IP do desenvolvedor). Atualizar via PR se o IP mudar."
  type        = string
  default     = "201.92.37.221/32"
}
