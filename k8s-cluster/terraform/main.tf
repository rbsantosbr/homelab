resource "local_file" "ansible_inventory" {
  filename = "/home/roberto/DevOps/homelab/k8s-cluster/kubespray/inventory/k8s-cluster/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    master = module.k8s_controlplane
    worker = module.k8s_worker
  })

  file_permission = "0600"

  depends_on = [
    module.k8s_controlplane,
    module.k8s_worker,
    null_resource.kubespray_requirements
  ]
}

resource "null_resource" "kubespray_requirements" {
  provisioner "local-exec" {
    working_dir = "../ansible"
    command     = "ansible-playbook playbook.yml"
  }
}

resource "null_resource" "kubespray_install" {
  provisioner "local-exec" {
    working_dir = "../"
    command     = "./cluster.sh > ansible_output.log 2>&1"
  }
  depends_on = [module.k8s_controlplane, module.k8s_worker, local_file.ansible_inventory]
}