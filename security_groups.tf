resource "aws_security_group" "k3s" {
  # name_prefix (em vez de name fixo) + create_before_destroy: evita o deadlock de uma
  # substituicao de SG que ainda esta anexada a instancia (nome duplicado bloquearia a
  # criacao da nova SG antes da antiga ser destruida).
  name_prefix = "${var.project_name}-k3s-sg-"
  description = "SSH aberto (deploy automatizado via GitHub Actions, IP de runner dinamico); HTTP/HTTPS abertos para a aplicacao; API do k3s (6443) fechada para a internet"
  vpc_id      = data.aws_vpc.shared.id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    description = "SSH (deploy via CI/CD e administracao) - autenticacao somente por chave (par k3s_ec2_key), sem senha"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
