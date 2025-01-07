output "master" {
  value = { for node in module.k8s_controlplane :
    node.vm_name => ({
      ip   = node.vm_ip_address
      host = node.vm_node_name
    })
  }
}

output "worker" {
  value = { for node in module.k8s_worker :
    node.vm_name => ({
      ip   = node.vm_ip_address
      host = node.vm_node_name
    })
  }
}


