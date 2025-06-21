data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "cocktails_resource_group" {
  name = "rg-${var.sub}-${var.region}-${var.environment}-${var.domain}-${var.sequence}"
}

data "azurerm_resource_group" "cocktails_global_resource_group" {
  name = "rg-${var.sub}-${var.region}-${var.global_environment}-${var.domain}-${var.sequence}"
}

data "azurerm_resource_group" "global_shared_resource_group" {
  name = "rg-${var.sub}-${var.region}-${var.global_environment}-shared-${var.sequence}"
}

data "azurerm_container_registry" "shared_acr" {
  name                = "acr${var.sub}${var.region}${var.global_environment}shared${var.sequence}"
  resource_group_name = data.azurerm_resource_group.global_shared_resource_group.name
}

data "azurerm_subnet" "cae_subnet" {
  name                 = "snet-${var.sub}-${var.region}-${var.global_environment}-sharedcontainers-${var.sequence}"
  virtual_network_name = "vnet-${var.sub}-${var.region}-${var.global_environment}-network-${var.sequence}"
  resource_group_name  = "rg-${var.sub}-${var.region}-${var.global_environment}-network-${var.sequence}"
}

data "azurerm_key_vault" "global_cocktails_keyvault" {
  name                = "kv-${var.sub}-${var.region}-${var.global_environment}-${var.shortdomain}-${var.short_sequence}"
  resource_group_name = data.azurerm_resource_group.cocktails_global_resource_group.name
}

data "azurerm_cdn_frontdoor_profile" "global_shared_cdn" {
  name                = "afd-${var.sub}-${var.region}-${var.global_environment}-shared-${var.sequence}"
  resource_group_name = data.azurerm_resource_group.global_shared_resource_group.name
}

data "azurerm_dns_zone" "cezzis_dns_zone" {
  name                = "cezzis.com"
  resource_group_name = data.azurerm_resource_group.cocktails_global_resource_group.name
}