resource "azurerm_key_vault_secret" "b2c_terraform_app_registration_client_id" {
  name         = "${var.environment}-b2c-terraform-app-registration-client-id"
  value        = "n/a"
  key_vault_id = data.azurerm_key_vault.global_cocktails_keyvault.id

  lifecycle {
    ignore_changes = [value]
  }

  tags = local.tags
}

resource "azurerm_key_vault_secret" "b2c_terraform_app_registration_client_secret" {
  name         = "${var.environment}-b2c-terraform-app-registration-client-secret"
  value        = "n/a"
  key_vault_id = data.azurerm_key_vault.global_cocktails_keyvault.id

  lifecycle {
    ignore_changes = [value]
  }

  tags = local.tags
}

resource "azurerm_key_vault_secret" "github_pat_mtnvencenzo_packages_readwrite" {
  name         = "${var.environment}-github-pat-mtnvencenzo-packages-readwrite"
  value        = "n/a"
  key_vault_id = data.azurerm_key_vault.global_cocktails_keyvault.id

  lifecycle {
    ignore_changes = [value]
  }

  tags = local.tags
}