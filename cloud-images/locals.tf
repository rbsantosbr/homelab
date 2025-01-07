locals {
  server = toset(["pve01", "pve02", "pve03"])

  image = {
    ubuntu-jammy = {

      nodename           = ""
      content_type       = "iso"
      datastore          = "local"
      url                = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
      checksum           = "0d8345a343c2547e55ac815342e6cb4a593aa5556872651eb47e6856a2bb0cdd"
      checksum_algorithm = "sha256"
    }

    ubuntu-oracular = {

      nodename           = ""
      content_type       = "iso"
      datastore          = "local"
      url                = "https://cloud-images.ubuntu.com/oracular/current/oracular-server-cloudimg-amd64.img"
      checksum           = "1f95f7a1449f54aba1ae589abac5df216dafcac9ae02ccb7ca764038b32a345e"
      checksum_algorithm = "sha256"
    }

    # rocky-8 = {
    #   nodename           = ""
    #   content_type       = "iso"
    #   datastore          = "local"
    #   url                = "https://dl.rockylinux.org/pub/rocky/8/images/x86_64/Rocky-8-GenericCloud-Base.latest.x86_64.qcow2"
    #   checksum           = ""
    #   checksum_algorithm = "sha256"
    # }

    # rocky-9 = {
    #   nodename           = ""
    #   content_type       = "iso"
    #   datastore          = "local"
    #   url                = "https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud-Base.latest.x86_64.qcow2"
    #   checksum           = "069493fdc807300a22176540e9171fcff2227a92b40a7985a0c1c9e21aeebf57"
    #   checksum_algorithm = "sha256"
    # }
  }

  product = merge([
    for server_key, server_value in local.server :
    {
      for image_key, image_value in local.image :
      "${server_key}-${image_key}" => {
        nodename           = server_value
        content_type       = image_value.content_type
        datastore          = image_value.datastore
        url                = image_value.url
        checksum           = image_value.checksum
        checksum_algorithm = image_value.checksum_algorithm
      }
    }
  ]...)
}
