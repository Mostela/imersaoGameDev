provider "aws" {
  region = "us-east-1"
  version = "~> 2.0"
  ## CHAVE INFORMADAS AQUI SAO INVALIDAS APOS O COMMIT
  #access_key = ""
  #secret_key = ""
  ## OU TROQUE PELO LOCAL ABSOLUTO DA CHAVE COM BASE NA RAIZ
  shared_credentials_file =  "/home/joao/.aws/credentials"
  profile = "terragiro"
}

resource "aws_instance" "mostelagame" {
  ami = "ami-0edfed9d6e9a4031b"
  instance_type = "t2.micro"
  tags = {Name = "mostela game"}
  key_name = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.alow_connect.name]
}

resource "aws_key_pair" "my-key" {
  key_name = "joaodesk"
  # Informe a chave SSH do computador antes
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "alow_connect"{
  name = "alow_connect"
  ingress {
      description = "Padrao SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      description = "Servidor Jogo"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_metric_alarm" "evitaGastos" {
  alarm_name                = "tf-mostelaGameUso"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "HighCPUCredit-Usage"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 custs for time"
}

output "mostelagame_public_dns" {
  value = aws_instance.mostelagame.public_dns
}

output "mostelagame_public_ip" {
  value = aws_instance.mostelagame.public_ip
}