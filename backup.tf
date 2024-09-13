resource "azurerm_backup_protected_vm" "backup_association" {
  resource_group_name = var.recovery_vault_rg_name == null ? var.resource_group_name : var.recovery_vault_rg_name
  recovery_vault_name = var.recovery_vault_name
  source_vm_id        = var.os_type == "Linux" ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  backup_policy_id    = var.backup_policy_id
}

resource "azurerm_role_assignment" "start_stop_role" {
  scope                = var.os_type == "Linux" ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  role_definition_name = "Virtual Machine Operator (start/stop)"
  principal_id         = var.backup_operator_principal_id
}
