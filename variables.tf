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
  description = "Tipo da instancia EC2 que hospeda o k3s. t3.micro (1GB RAM) se mostrou instavel sob a carga de k3s + Traefik + CoreDNS + a aplicacao (SSH parava de responder); t3.small (2GB) da folga de memoria."
  type        = string
  default     = "t3.small"
}
