provider "aws" {
  region = "us-east-1"
  version = "~> 2.0"
  ## CHAVE INFORMADAS AQUI SAO INVALIDAS APOS O COMMIT
  access_key = ""
  secret_key = ""
  ## OU TROQUE PELO LOCAL ABSOLUTO DA CHAVE COM BASE NA RAIZ
  #shared_credentials_file =  "/home/joao/.aws/credentials"
  profile = "terragiro"
}

resource "aws_instance" "mostelagame" {
  ami = "ami-0edfed9d6e9a4031b"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.my-key.key_name}"
  security_groups = ["${aws_security_group.alow_connect.name}"]
}

resource "aws_key_pair" "my-key" {
  key_name = "joaodesk"
  # Informe a chave SSH do computador antes
  public_key = ""
}

resource "aws_security_group" "alow_connect"{
  name = "alow_connect"
  ingress = [
    {
      description = "Padrao SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Servidor Jogo"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "mostelagame_public_dns" {
  value = "${aws_instance.mostelagame.public_dns}"
}

output "mostelagame_public_ip" {
  value = "${aws_instance.mostelagame.public_ip}"
}