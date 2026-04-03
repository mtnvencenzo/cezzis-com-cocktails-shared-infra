# =====================================================
# FRONT DOOR APIM COCKTAILS ORIGIN GROUP + ORIGIN + ROUTE
# =====================================================

resource "azurerm_cdn_frontdoor_origin_group" "og_apim_cocktails" {
  name                     = "og-apim-cocktails"
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
  session_affinity_enabled = false

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin_apim_cocktails" {
  name                          = "origin-apim-cocktails"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og_apim_cocktails.id
  enabled                       = true

  certificate_name_check_enabled = true
  host_name                      = "${data.azurerm_api_management.shared_apim.name}.azure-api.net"
  origin_host_header             = "${data.azurerm_api_management.shared_apim.name}.azure-api.net"
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
}

resource "azurerm_cdn_frontdoor_route" "route_apim_cocktails" {
  name                          = "route-apim-cocktails"
  cdn_frontdoor_endpoint_id     = data.azurerm_cdn_frontdoor_endpoint.global_shared_cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og_apim_cocktails.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin_apim_cocktails.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match = [
    "/${var.environment}/cocktails/api/*",
    "/${var.environment}/cocktails/api-docs/*"
  ]
  supported_protocols    = ["Http", "Https"]
  link_to_default_domain = true

  cdn_frontdoor_custom_domain_ids = var.include_apex_domain_records ? [
    azurerm_cdn_frontdoor_custom_domain.apex_cezzis[0].id,
    azurerm_cdn_frontdoor_custom_domain.www_cezzis[0].id,
  ] : []
}
