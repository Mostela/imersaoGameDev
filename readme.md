# As aventuras da bruxinha Alcides
 
## Imersão Game Dev - Alura.

### Objetivo

O objetivo e criar um jogo simples usando apenas JavaScript e a biblioteca: [p5js](https://p5js.org/)

### Como jogar

Aperta a tecla do seu teclado, seta para cima para pular.

### Vagrant e Ansible

Disponível para execução em maquina virtual (vagrant) no caso de maquina local com servidor nginx.

Siga os comandos a baixo para realizar a criação da maquina.
Apos estará disponível o jogo na porta 3000 do seu computador.

    vagrant up --provision
    
    
_Foi usado Vagrant no lugar do Docker e containers para auxiliar na configuração do Ansible para o servidor._

### Terraform e Ansible

Para criação de um servidor para o jogo na **AWS** rode os comandos abaixo.

Aviso! precisa ter uma credencial na AWS antes de prosseguir e configurar o arquivo awsMachine.tf para as suas credenciais.

1. Criando a maquina.

        terraform init
        terraform apply
        
    Confirme com *Yes* e copie o DNS
        
1. Configurando o Ansible
        
        cd /etc/ansible
        sudo echo "[maquinaAws]" >> hosts
        sudo echo "<TroquepeloDNS> ansible_ssh_user=ubuntu ansible_python_interpreter=/usr/bin/python3" >> hosts
        
        
1. Execute o playbook nessa pasta
    
    ansible maquinaAws -m ping
    
Aguarde uma resposta positiva e execute o comando abaixo e espere finalizar todos os passos.
    
    ansible-playbook playbook.yml
    
    
Pronto este configurado o seu servidor com o jogo na AWS
Use o DNS obtido anteriormente para acessar o mesmo na porta 80 