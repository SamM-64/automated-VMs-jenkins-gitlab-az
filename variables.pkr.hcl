client_id         = "$CLIENT_ID"
client_secret     = "$CLIENT_SECRET"
subscription_id   = "$SUBSCRIPTION_ID"
tenant_id         = "$TENANT_ID"


# Définition de la variable pour l'ID de l'application principale de service Azure.
variable "client_id" {
  type        = string
  description = "Azure Service Principal App ID used for authentication and access."
  sensitive   = true

}

# Définition de la variable pour le secret de l'application principale de service Azure.
variable "client_secret" {
  type        = string
  description = "Secret associated with the Azure Service Principal for secure authentication."
  sensitive   = true 
}

# Définition de la variable pour l'ID d'abonnement Azure.
variable "subscription_id" {
  type        = string
  description = "Unique identifier for the Azure Subscription where resources will be provisioned."
  sensitive   = true
}

# Définition de la variable pour l'ID du locataire Azure.
variable "tenant_id" {
  type        = string
  description = "Tenant ID associated with the Azure Active Directory."
  sensitive   = true
}

# Définition de la variable pour le groupe de ressources où Packer construira l'image.
variable "build_resource_group" {
  type        = string
  description = "Name of the Azure Resource Group where the Packer build process will create and store resources."
  default     = "b3-gr1"
}

# Définition de la variable pour l'offre de l'image source.
variable "source_image_offer" {
  type        = string
  description = "Offer name of the source image to be used as the base for customization."
  default     = "0001-com-ubuntu-server-jammy"
}

# Définition de la variable pour l'éditeur de l'image source.
variable "source_image_publisher" {
  type        = string
  description = "Publisher name of the source image."
  default     = "canonical"
}

# Définition de la variable pour la version du SKU de l'image source.
variable "source_image_sku" {
  type        = string
  description = "Stock Keeping Unit (SKU) of the source image."
  default     = "22_04-lts"
}

# Définition de la variable pour le nom de l'image gérée après la création.
variable "managed_image_name" {
  type        = string
  description = "Name of the managed image to be created after customization."
  default     = "b3-gr1-app"
}

# Définition de la variable pour le type d'OS de la machine virtuelle.
variable "os_type" {
  type        = string
  description = "Type of the operating system for the virtual machine (e.g., Linux, Windows)."
  default     = "Linux"
}

# Définition de la variable pour la taille de la machine virtuelle.
variable "vm_size" {
  type        = string
  description = "Size specification for the virtual machine in terms of CPU, memory, and storage."
  default     = "Standard_DS2_v2"
}
