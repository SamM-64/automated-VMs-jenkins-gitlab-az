data "azurerm_resource_group" "main" {
  name = local.squad_name
}

data "azurerm_image" "linux_packer" {
  name_regex          = "^${local.squad_name}-\\d*"
  sort_descending     = true
  resource_group_name = data.azurerm_resource_group.main.name
}