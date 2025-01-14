output "hosts" {
  value = { for node in module.bind9 :
    node.vm_name => ({
      ip   = node.vm_ip_address
      host = node.vm_node_name
    })
  }
}