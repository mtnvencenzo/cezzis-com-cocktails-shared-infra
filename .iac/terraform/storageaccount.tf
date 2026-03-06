module "cocktails_storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/storage-account"

  sub                     = var.sub
  region                  = var.region
  environment             = var.environment
  domain                  = var.domain
  name_discriminator      = ""
  short_sequence          = var.sequence
  resource_group_name     = data.azurerm_resource_group.cocktails_resource_group.name
  resource_group_location = data.azurerm_resource_group.cocktails_resource_group.location
  allowed_origins         = var.allowed_origins

  tags = local.tags

  blob_containers = [
    {
      name                  = "cocktails"
      container_access_type = "blob"
    }
  ]

  providers = {
    azurerm = azurerm
  }
}