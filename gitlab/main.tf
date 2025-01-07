module "gitlab" {
  source = "github.com/BarryL4bs/terraform-bpg-proxmox-vm?ref=v1.1"

  count = 1

  vm_name        = "gitlab"
  vm_description = "Managed by Terraform"
  vm_tags        = ["homelab", "gitlab", "git", "cicd"]
  nodename       = "pve02"
  vm_id          = "3002"

  cpu = {
    cores = 4
    type  = "x86-64-v2-AES"
  }
  memory = 4096

  agent = true

  disk = {
    datastore = "ceph-storage"
    image     = "local:iso/jammy-server-cloudimg-amd64.img"
    interface = "virtio0"
    iothread  = true
    discard   = "on"
    size      = 100
    format    = "raw"
  }

  dns = ["8.8.8.8", "8.8.4.4"]

  ipv4 = {
    address = "10.10.11.21/26"
    gateway = "10.10.11.1"
  }

  snippet = "local:snippets/ubuntu.cloud-config.yaml"

  net_interface = {
    bridge = "vmbr0"
    vlan   = "11"
  }

  os_type = "l26"

}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    hosts = module.gitlab
  })

  file_permission = "0600"

  depends_on = [
    module.gitlab
  ]
}

resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    working_dir = "./ansible"
    command     = "ansible-playbook gitlab.yml"
  }
  depends_on = [module.gitlab, local_file.ansible_inventory]
}

