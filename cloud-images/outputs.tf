output "id" {
  value = {
    for k, v in module.cloud-image :
    k => v.id
  }
}