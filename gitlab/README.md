# Gitlab

Criação de um ambiente Gitlab *Self-Hosted* baseado em docker, com certificados ssl auto-assinados.

Neste projeto, utilizo o terraform para provisionamento da VM no Proxmox. Em seguida utilizo o ansible para as configurações necessárias no ambiente, tais como alterar configurações do `sshd`, instalar o `docker` e `docker compose`, e executar os `services`definidos no arquivo `compose.yml`.

## Requisitos

* Proxmox VE;
* Conhecimentos em ansible;
* Conhecimentos em Terraform;
* Certificado SSL auto-assinado.

## Como utilizar

1- Alterar os seguintes parâmetros no arquivo `ansible/files/compose.yml`:

* `image`: nome da imagem e tag;
* `hostname`: nome do host dentro do container;
* Alterar a variável de ambiente `GITLAB_OMNIBUS_CONFIG` e definir a `external_url` e a `registry_external_url`respectivamente.

2- Ajustar o arquivo `main.tf`e alterar as propriedades da VM, conforme sua necessidade/ capacidade.

3- Aplicar as configurações utilizando o terraform.

4- Executar o comando `docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`para recuperar a senha do usuário **root** e acessar o sistema.

## Notas

* Este projeto utiliza o módulo [terraform-bpg-proxmox-vm](https://github.com/BarryL4bs/terraform-bpg-proxmox-vm);
* É necessário os certificados auto-assinados, com o seu nome de domínio.
