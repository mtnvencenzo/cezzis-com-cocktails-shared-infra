module "cocktails_frontdoor_cdn_storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/frontdoor-cdn-endpoint-with-origin"

  sub                      = var.sub
  region                   = var.region
  environment              = var.environment
  domain                   = var.domain
  sequence                 = var.sequence
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
  origin_host_name         = module.cocktails_storage_account.primary_blob_host

  tags = local.tags

  custom_domain = {
    dns_zone_id             = data.azurerm_dns_zone.cezzis_dns_zone.id
    dns_zone_name           = "cezzis.com"
    dns_zone_resource_group = data.azurerm_resource_group.cocktails_global_resource_group.name
    sub_domain              = "cdn"
    host_name               = "cdn.cezzis.com"
  }

  allowed_origins = var.allowed_origins

  caching_rule = {
    cache_duration       = "60.00:00:00"
    ignore_query_strings = true
    compression_enabled  = true
  }

  providers = {
    azurerm = azurerm
  }
}