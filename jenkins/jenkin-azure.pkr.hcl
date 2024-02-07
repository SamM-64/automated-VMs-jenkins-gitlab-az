# Définition de la source pour créer une image Azure ARM pour Jenkins Server
source "azure-arm" "Jenkins_Server" {
  
  # Tags Azure qui seront appliqués à la ressource créée
  azure_tags = {
    dept = "Engineering"
    task = "Jenkins Server deployment"
  }
  
  # Identifiants et configurations Azure
  client_id                         = "e99defea-a429-42a1-95a5-a524709053eb"
  client_secret                     = "GGj8Q~hb61R4Fbs9HukgXexEvwFiuYNeqynORbGU"
  subscription_id                   = "c56aea2c-50de-4adc-9673-6a8008892c21"
  tenant_id                         = "16763265-1998-4c96-826e-c04162b1e041" 
  image_offer                       = "UbuntuServer"
  image_publisher                   = "Canonical"
  image_sku                         = "20.04-LTS"
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
