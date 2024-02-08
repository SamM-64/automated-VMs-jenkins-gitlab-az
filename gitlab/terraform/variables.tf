variable "public_access" {
  description = "The boolean value to enable/disable public access to the virtual machine"
  type        = bool
  default     = true
}
variable "allocation" {
  type    = string
  default = "Static"
}
variable "sku_value" {
  type    = string
  default = "Standard"
}
variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "vm-gitlab"
}

variable "ip_name" {
  type    = string
  default = "internal"
}
variable "private_allocation" {
  type    = string
  default = "Dynamic"
}
variable "vm_size" {
  type    = string
  default = "Standard_B4ms"
}
variable "use_ssh_key" {
  description = "A boolean that indicates whether to use SSH key for authentication. If true, SSH key is used; if false, password is used."
  type        = bool
  default     = true
}

variable "ssh_public_key" {
  type        = string
  description = "This variable defines the SSH Public Key for Linux"
  default     = null
}
variable "caching" {
  type    = string
  default = "ReadWrite"
}
variable "storage_type" {
  type    = string
  default = "Standard_LRS"
}
variable "source_image_reference" {
  description = "Custom source image reference"
  type        = map(string)
  default     = {}
}
variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "nsg"
}

variable "tags" {
  description = "A mapping of tags"
  type        = map(string)
  default = {
    dept        = "Engineering"
    task        = "Image deployment"
    environment = "test"
  }
}

variable "admin_password" {
  description = "Virtual machine administrator password"
  type        = string
}
