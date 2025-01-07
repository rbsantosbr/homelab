locals {

  # Common configs

  node = "pve0"

  cpu_type = "x86-64-v2-AES"

  agent = true

  disk = {
    datastore = "local-lvm"
    image     = "jammy-server-cloudimg-amd64.img"
    interface = "virtio0"
    iothread  = true
    discard   = "on"
  }

  dns = ["8.8.8.8", "8.8.4.4"]

  ipv4 = {
    address = "static"
  }

  cidr = "192.168.128.0/25"

  snippet = "local:snippets/ubuntu.cloud-config.yaml"

  net_interface = {
    bridge = "vmbr0"
    vlan   = "128"
  }

  os_type = "l26"

  # Control Plane configs
  controlplane = {

    hostname    = "k8s-controlplane-0"
    vm_id       = "100"
    tags        = ["homelab", "k8s", "controlplane", "ubuntu", "terraform"]
    cpu         = 2
    memory      = 3072
    disk_size   = 40
    disk_format = "raw"
    last_octet  = 70
  }

  # Worker configs
  worker = {

    hostname    = "k8s-worker-0"
    vm_id       = "200"
    tags        = ["homelab", "k8s", "worker", "ubuntu", "terraform"]
    cpu         = 4
    memory      = 6144
    disk_size   = 60
    disk_format = "raw"
    last_octet  = 90
  }
}