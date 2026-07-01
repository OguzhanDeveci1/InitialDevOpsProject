# 1. Güvenlik Duvarı (Security Group)
resource "aws_security_group" "web_sg" {
  name        = "devops-project-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.main.id

  
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Canlı ortamda sadece kendi IP'niz verilir ama test için açık bırakıyoruz
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_server" {
  ami           = "ami-0303e2e4a29f041a3"
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  # 🔑 İŞTE EKSİK OLAN SATIR:
  key_name      = "tezkey" # AWS'deki Key Pair adın neyse onu yaz

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = { Name = "HelloDevOps-Server" }

}