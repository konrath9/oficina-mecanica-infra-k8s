resource "aws_key_pair" "k3s" {
  key_name   = "${var.project_name}-k3s"
  public_key = file("${path.module}/k3s_ec2_key.pub")
}

resource "aws_instance" "k3s" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.k3s.id]
  iam_instance_profile   = "LabInstanceProfile"
  key_name               = aws_key_pair.k3s.key_name
  user_data              = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "${var.project_name}-k3s"
    Project = var.project_name
  }
}

resource "aws_eip" "k3s" {
  instance = aws_instance.k3s.id
  domain   = "vpc"

  tags = {
    Name    = "${var.project_name}-k3s-eip"
    Project = var.project_name
  }
}
