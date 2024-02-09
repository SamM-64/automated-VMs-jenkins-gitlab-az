resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_ssh_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.root}/ssh/id_rsa"
  file_permission = "0600"
}

# Create virtual network
resource "azurerm_virtual_network" "network" {
  name                = "${var.vm_name}-network"
  address_space       = ["10.1.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

# Create subnet
resource "azurerm_subnet" "main" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.1.1.0/24"]
}

#Create a public IP for the VM, if public_access variable is set to true
resource "azurerm_public_ip" "main" {
  name                = "${var.vm_name}-pip"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = var.allocation
  sku                 = var.sku_value
  domain_name_label   = "${var.vm_name}-ecf"
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

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = data.azurerm_resource_group.main.location
  resource_group_name   = data.azurerm_resource_group.main.name
  admin_username        = local.ssh_user
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = var.vm_size

  admin_ssh_key {
    public_key = tls_private_key.ssh_key.public_key_openssh
    username   = local.ssh_user
  }
  os_disk {
    caching              = "ReadWrite"
    name                 = "${var.vm_name}-disk-os"
    storage_account_type = "Premium_LRS"
  }
  source_image_id = data.azurerm_image.linux_packer.id
}

# NSG Rules
locals {
  ssh_user = "azureuser"
  ssh_whitelist = {
    sam     = "91.162.171.239"
    jous    = "86.213.70.36"
    dom     = "145.224.125.1"
    Simplon = "82.126.234.200"
    MSLab   = "185.175.148.123"
  }
  ssh_whitelist_list = values(local.ssh_whitelist)
}

resource "azurerm_network_security_group" "vm" {
  name                = "${var.vm_name}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  dynamic "security_rule" {
    for_each = { for i, v in local.ssh_whitelist_list : v => i }
    content {
      name                       = "SSH-${security_rule.value}"
      priority                   = 100 + security_rule.value
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = security_rule.key
      destination_address_prefix = azurerm_network_interface.main.private_ip_address
    }
  }
  dynamic "security_rule" {
    for_each = { for i, v in local.ssh_whitelist_list : v => i }
    content {
      name                       = "HTTP-${security_rule.value}"
      priority                   = 200 + security_rule.value
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = security_rule.key
      destination_address_prefix = azurerm_network_interface.main.private_ip_address
    }
  }
  dynamic "security_rule" {
    for_each = { for i, v in local.ssh_whitelist_list : v => i }
    content {
      name                       = "HTTPS-${security_rule.value}"
      priority                   = 300 + security_rule.value
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = security_rule.key
      destination_address_prefix = azurerm_network_interface.main.private_ip_address
    }
  }
}

resource "azurerm_network_interface_security_group_association" "association_nsg_network-gitlab" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.vm.id
}