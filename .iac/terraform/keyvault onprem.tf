module "keyvault_onprem" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/key-vault"

  providers = {
    azurerm = azurerm
  }

  tags = local.tags

  sub                     = var.sub
  region                  = var.region
  environment             = "prm"
  domain                  = var.domain
  shortdomain             = var.shortdomain
  sequence                = var.short_sequence
  tenant_id               = data.azurerm_client_config.current.tenant_id
  pipeline_object_id      = data.azurerm_client_config.current.object_id
  resource_group_name     = data.azurerm_resource_group.cocktails_resource_group.name
  resource_group_location = data.azurerm_resource_group.cocktails_resource_group.location

  virtual_network_subnet_ids = [
    data.azurerm_subnet.cae_subnet.id
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
    }
  ]

  secrets_values_ignored = [
    {
      name  = "cezzis-platform-onprem-sp-client-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "cezzis-blob-storage-connection-string"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "cezzis-blob-storage-access-key"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "zoho-email-app-password"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "auth0-management-client-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "recaptcha-site-key"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "recaptcha-site-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "cypress-user-1-password"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "daprio-dapr-api-token"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "daprio-app-api-token"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "auth0-cookie-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "auth0-web-client-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "cocktails-embedding-agent-oauth-client-secret"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "cocktails-api-cezzis-com-subscription-primary-key"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "aisearch-api-cezzis-com-subscription-primary-key"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    },
    {
      name  = "accounts-api-cezzis-com-subscription-primary-key"
      value = "n/a"
      tags = {
        Application = var.domain
        Environment = "prm"
      }
    }
  ]
}

