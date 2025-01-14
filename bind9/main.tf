module "bind9" {
  source = "github.com/BarryL4bs/terraform-bpg-proxmox-vm?ref=v1.1"

  count = 1

  vm_name        = "bind9"
  vm_description = "Managed by Terraform"
  vm_tags        = ["homelab", "dns", "bind9"]
  nodename       = "pve01"
  vm_id          = "3003"

  cpu = {
    cores = 2
    type  = "x86-64-v2-AES"
  }
  memory = 2048

  agent = true

  disk = {
    datastore = "ceph-storage"
    image     = "local:iso/jammy-server-cloudimg-amd64.img"
    interface = "virtio0"
    iothread  = true
    discard   = "on"
    size      = 50
    format    = "raw"
  }

  dns = ["1.1.1.1", "1.0.0.1"]

  ipv4 = {
    address = "10.10.11.10/26"
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
    hosts = module.bind9
  })

  file_permission = "0600"

  depends_on = [
    module.bind9
  ]
}

resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    working_dir = "./ansible"
    command     = "ansible-playbook bind9.yml"
  }
  depends_on = [module.bind9, local_file.ansible_inventory]
}

