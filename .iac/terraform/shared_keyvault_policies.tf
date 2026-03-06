resource "azurerm_key_vault_access_policy" "cezzis_onprem_sp_policy" {
  key_vault_id       = data.azurerm_key_vault.global_keyvault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = var.cezzis_platform_onprem_service_principal_object_id
  key_permissions    = ["Get", "List"]
  secret_permissions = ["Get", "List"]

  depends_on = [
    data.azurerm_key_vault.global_keyvault
  ]
}