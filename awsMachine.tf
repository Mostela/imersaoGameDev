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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD/AEafh3mnxSvWHFI9ufHhxwJQEfGxuvkPfUtrFzVpTbY1s4a0VFZzhwj5t9m8/IlE4+P5zqeqR2yy7p6Y0B/QRtTHwYp/A+YuAaTy+RopPXPYvQlq6RIJCBVCZzOVrKH8fBB2MIgxo3+WkDeMBIeKoOoc+2AlUpZPCzon/Yyf0grb0DUbb7+U7qiOuEt2aUKJ2aRXecc05rX0CKzm8t/t5G9Cz/51hW/a23vk75xNYZ2hmt746JFzZKiiymZHhPpahSo5eUycSfP1mXmSYomop4oeOVoiYH8wevdkki7gtUkUvXEcKHG5TZXnIdsvpmnnOnCbPsyG/wl8z4eXqa77 joao@joaodesk"
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
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Redirecionamento da 80 (Default) para do jogo"
      from_port = 80
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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