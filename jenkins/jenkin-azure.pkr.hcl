# Définition de la source pour créer une image Azure ARM pour Jenkins Server
source "azure-arm" "Jenkins_Server" {
  
  # Tags Azure qui seront appliqués à la ressource créée
  azure_tags = {
    dept = "Engineering"
    task = "Jenkins Server deployment"
  }
  
  # Identifiants et configurations Azure
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  image_offer                       = "UbuntuServer"
  image_publisher                   = "Canonical"
  image_sku                         = "18.04-LTS"
  managed_image_name                = "Samantha_M_jenkins"
  build_resource_group_name         = "Samantha_M"
  managed_image_resource_group_name = "Samantha_M"
  os_type                           = "Linux"
  vm_size                           = "Standard_B4ms"
}

build {
  sources = ["source.azure-arm.Jenkins_Server"]

  # Provisioning: executes shell commands on the virtual machine
  provisioner "shell" {
    script = "./setup.sh"
   

  }
}
