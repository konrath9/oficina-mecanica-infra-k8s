resource "aws_security_group" "k3s" {
  name        = "${var.project_name}-k3s-sg"
  description = "SSH restrito ao IP do desenvolvedor; HTTP/HTTPS abertos para a aplicacao; API do k3s (6443) fechada para a internet"
  vpc_id      = data.aws_vpc.shared.id

  ingress {
    description = "SSH (deploy e administracao)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "HTTP (Traefik, ingress padrao do k3s)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS (Traefik, ingress padrao do k3s)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-k3s-sg"
    Project = var.project_name
  }
}
