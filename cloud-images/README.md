# Cloud Images

O cloud images é um projeto desenvolvido em Terraform, e utiliza o módulo [terraform-bpg-proxmox-cloud-image](https://github.com/BarryL4bs/terraform-bpg-proxmox-cloud-image) que simplifica o download de imagens de máquinas virtuais à serem utilizadas no Proxmox.

## Requisitos

* Proxmox VE.

## Como utilizar

1- Configurar as variáveis requeridas pelo módulo (vide requisitos no link acima);
2- Alterar o arquivo `locals.tf` adicionando o nome do(s) host(s), URL das imagens e demais parâmetros de acordo ao seu ambiente proxmox.
