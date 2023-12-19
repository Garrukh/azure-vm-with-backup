data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg_name == null ? var.resource_group_name : var.keyvault_rg_name
}

resource "random_password" "admin_password" {
  count = var.admin_password == null ? 0 : 1
  length  = 16
  lower   = true
  upper   = true
  numeric = true
  special = false
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = var.secret_name
  value        = random_password.admin_password[0].result
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = var.admin_username
}