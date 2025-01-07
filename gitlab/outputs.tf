output "hosts" {
  value = { for node in module.gitlab :
    node.vm_name => ({
      ip   = node.vm_ip_address
      host = node.vm_node_name
    })
  }
}