module "cloud-image" {
  source = "github.com/BarryL4bs/terraform-bpg-proxmox-cloud-image?ref=v1.0"

  for_each = local.product

  content_type       = each.value.content_type
  datastore          = each.value.datastore
  nodename           = each.value.nodename
  url                = each.value.url
  checksum           = each.value.checksum
  checksum_algorithm = each.value.checksum_algorithm
}
