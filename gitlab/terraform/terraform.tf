# Locate the existing resource group
data "azurerm_resource_group" "main" {
  name = "Samantha_M"
}

# Locate the existing custom image
data "azurerm_image" "image" {
  name                = "Samantha_M_app"
  resource_group_name = data.azurerm_resource_group.main.name
}

# Create virtual network
resource "azurerm_virtual_network" "network" {
  name                = "${data.azurerm_resource_group.main.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  tags                = var.tags

}

# Create subnet
resource "azurerm_subnet" "main" {
  name                 = "${data.azurerm_resource_group.main.name}-subnet"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.100.0/24"]
}

#Create a public IP for the VM, if public_access variable is set to true
resource "azurerm_public_ip" "main" {
  name                = "${var.vm_name}-pip"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = var.allocation
  sku                 = var.sku_value
  tags                = var.tags
}

#Create a network interface
resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = var.private_allocation
    public_ip_address_id          = azurerm_public_ip.main.id
  }
  tags = var.tags
}

# Create a Virtual Machine based on the custom Image
resource "azurerm_virtual_machine" "VM" {
  name                             = var.vm_name
  location                         = data.azurerm_resource_group.main.location
  resource_group_name              = data.azurerm_resource_group.main.name
  network_interface_ids            = [azurerm_network_interface.main.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.image.id
  }

  storage_os_disk {
    name              = "VM-OS"
    caching           = var.caching
    create_option     = "FromImage"
    managed_disk_type = var.storage_type
  }

  os_profile {
    computer_name  = "APPVM"
    admin_username = "sammss"
    admin_password = "P@$$w0rd1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}
