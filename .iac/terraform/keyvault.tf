resource "random_password" "shared-dapr-app-token" {
  length  = 24
  special = false
  upper   = true
  lower   = true
  numeric = true
}

resource "random_password" "shared-dapr-api-token" {
  length  = 24
  special = false
  upper   = true
  lower   = true
  numeric = true
}


module "aca_cocktails_api" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/key-vault"

  providers = {
    azurerm = azurerm
  }

  tags = local.tags

  sub                     = var.sub
  region                  = var.region
  environment             = var.environment
  domain                  = var.domain
  shortdomain             = var.shortdomain
  sequence                = var.short_sequence
  tenant_id               = data.azurerm_client_config.current.tenant_id
  pipeline_object_id      = data.azurerm_client_config.current.object_id
  resource_group_name     = data.azurerm_resource_group.cocktails_resource_group.name
  resource_group_location = data.azurerm_resource_group.cocktails_resource_group.location

  virtual_network_subnet_ids = [
    # data.azurerm_subnet.cae_subnet.id
  ]

  access_policies = [
    {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = var.cezzis_platform_onprem_service_principal_object_id

      secret_permissions = ["Get", "List"]
      key_permissions    = ["Get", "List"]
    }
  ]

  secrets = [
    {
      name  = "shared-container-registry-password"
      value = data.azurerm_container_registry.shared_acr.admin_password
    },
    {
      name  = "shared-dapr-app-token"
      value = random_password.shared-dapr-app-token.result
    },
    {
      name  = "shared-dapr-api-token"
      value = random_password.shared-dapr-api-token.result
    }
  ]

  secrets_values_ignored = [
    {
      name  = "cezzis-platform-onprem-sp-client-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = var.environment
      }
    },
    {
      name  = "cezzis-blob-storage-connection-string-onprem"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = var.environment
      }
    },
    {
      name  = "cezzis-blob-storage-access-key-onprem"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = var.environment
      }
    },
  ]
}