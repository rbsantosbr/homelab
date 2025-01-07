output "hosts" {
  value = { for node in module.minio :
    node.vm_name => ({
      ip   = node.vm_ip_address
      host = node.vm_node_name
    })
  }
}