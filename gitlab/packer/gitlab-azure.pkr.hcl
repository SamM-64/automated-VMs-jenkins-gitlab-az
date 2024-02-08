locals {
  build_date = formatdate("YYYYMMDD-hhmmss", timestamp())
  image_name = "${var.project_prefix}-${var.project_name}-${local.build_date}"
  scripts_path = "${path.root}/../scripts"
}

# Définition de la source pour créer une image Azure ARM pour gitlab Server
source "azure-arm" "gitlab_Server" {

  # Tags Azure qui seront appliqués à la ressource créée
  azure_tags = {
    dept = "Engineering"
    task = "gitlab Server deployment"
  }

  # Identifiants et configurations Azure
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "Canonical"
  image_sku                         = "22_04-lts"
  build_resource_group_name         = "Samantha_M"
  os_type                           = "Linux"
  vm_size                           = "Standard_B4ms"


  managed_image_resource_group_name = var.project_prefix
  managed_image_name                = local.image_name
}

build {
  sources = ["source.azure-arm.ubuntu"]
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    scripts = [
      "${local.scripts_path}/setup.sh",
      "${local.scripts_path}/cerbot",
      "${local.scripts_path}/adduser_sudoer.sh",
    ]
  }
}