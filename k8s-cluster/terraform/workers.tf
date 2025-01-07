module "k8s_worker" {
  source = "github.com/BarryL4bs/terraform-bpg-proxmox-vm?ref=v1.1"

  count = 1

  vm_name        = format("%s%s", local.worker["hostname"], count.index + 1)
  vm_description = "Managed by Terraform"
  vm_tags        = local.worker["tags"]
  nodename       = format("%s%s", local.node, count.index + 1)
  vm_id          = format("%s%s", local.worker["vm_id"], count.index + 1)

  cpu    = { cores = local.worker["cpu"], type = local.cpu_type }
  memory = local.worker["memory"]

  agent = local.agent

  disk = {
    datastore = local.disk.datastore
    image     = "local:iso/${local.disk.image}"
    interface = local.disk.interface
    iothread  = local.disk.iothread
    discard   = local.disk.discard
    size      = local.worker["disk_size"]
    format    = local.worker["disk_format"]
  }

  dns = local.dns

  ipv4 = {
    address = local.ipv4["address"] == "dhcp" ? "dhcp" : format("%s%s", tostring(cidrhost(local.cidr, local.worker["last_octet"] + count.index)), "/25") # Revisar esta linha
    gateway = local.ipv4["address"] == "dhcp" ? null : cidrhost(local.cidr, 1)
  }

  snippet = local.snippet

  net_interface = {
    bridge = local.net_interface["bridge"]
    vlan   = local.net_interface["vlan"]
  }

  os_type = local.os_type

}