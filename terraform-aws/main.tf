provider "aws" {
  access_key = var.acces_key
  secret_key = var.secret_key
  region     = var.region

}

resource "aws_instance" "my_ubuntu" {
  ami                    = var.disk_image
  instance_type          = "t2.micro"
  key_name               = "test-project"
  vpc_security_group_ids = [aws_security_group.firewall_puma.id]
  tags = {
    Name = "reddit-app"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "aws_security_group" "firewall_puma" {
  name = "allow-puma-default"

  ingress {
    from_port   = 9292
    to_port     = 9292
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
