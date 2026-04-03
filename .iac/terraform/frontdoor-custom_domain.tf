# =====================================================
# FRONT DOOR CUSTOM DOMAINS
# =====================================================

resource "azurerm_cdn_frontdoor_custom_domain" "apex_cezzis" {
  count                    = var.include_apex_domain_records ? 1 : 0
  name                     = "cd-apex-cezzis"
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
  dns_zone_id              = data.azurerm_dns_zone.cezzis_dns_zone.id
  host_name                = "cezzis.com"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "www_cezzis" {
  count                    = var.include_apex_domain_records ? 1 : 0
  name                     = "cd-www-cezzis"
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
  dns_zone_id              = data.azurerm_dns_zone.cezzis_dns_zone.id
  host_name                = "www.cezzis.com"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

# =====================================================
# CUSTOM DOMAIN ASSOCIATIONS
# =====================================================

resource "azurerm_cdn_frontdoor_custom_domain_association" "apex_cezzis" {
  count                          = var.include_apex_domain_records ? 1 : 0
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.apex_cezzis[0].id
  cdn_frontdoor_route_ids = [
    azurerm_cdn_frontdoor_route.route_cdn_cz.id,
    azurerm_cdn_frontdoor_route.route_apim_cocktails.id,
  ]
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "www_cezzis" {
  count                          = var.include_apex_domain_records ? 1 : 0
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.www_cezzis[0].id
  cdn_frontdoor_route_ids = [
    azurerm_cdn_frontdoor_route.route_cdn_cz.id,
    azurerm_cdn_frontdoor_route.route_apim_cocktails.id,
  ]
}
