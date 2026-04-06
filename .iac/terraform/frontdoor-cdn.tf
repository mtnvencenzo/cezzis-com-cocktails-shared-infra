resource "azurerm_cdn_frontdoor_origin_group" "og_cdn_cz" {
  name                     = "og-cdn-cz"
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
  session_affinity_enabled = false

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin_cdn_cz" {
  name                          = "origin-cdn-cz"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og_cdn_cz.id
  enabled                       = true

  certificate_name_check_enabled = true
  host_name                      = module.cocktails_storage_account.primary_blob_host
  origin_host_header             = module.cocktails_storage_account.primary_blob_host
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
}

resource "azurerm_cdn_frontdoor_rule_set" "rs_cdn_cz" {
  name                     = "rscdncz"
  cdn_frontdoor_profile_id = data.azurerm_cdn_frontdoor_profile.global_shared_cdn.id
}

resource "azurerm_cdn_frontdoor_rule" "rule_cdn_cz_cache" {
  name                      = "cachecdncz"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.rs_cdn_cz.id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior                = "OverrideAlways"
      cache_duration                = "60.00:00:00"
      query_string_caching_behavior = "IgnoreQueryString"
    }
  }
}

resource "azurerm_cdn_frontdoor_route" "route_cdn_cz" {
  name                          = "route-cdn-cz"
  cdn_frontdoor_endpoint_id     = data.azurerm_cdn_frontdoor_endpoint.global_shared_cdn_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.og_cdn_cz.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin_cdn_cz.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.rs_cdn_cz.id]
  enabled                       = true

  forwarding_protocol       = "HttpsOnly"
  https_redirect_enabled    = true
  patterns_to_match         = ["/cdn/cz/*"]
  supported_protocols       = ["Http", "Https"]
  cdn_frontdoor_origin_path = "/"
  link_to_default_domain    = true

  cdn_frontdoor_custom_domain_ids = var.include_apex_domain_records ? [
    azurerm_cdn_frontdoor_custom_domain.apex_cezzis[0].id,
    azurerm_cdn_frontdoor_custom_domain.www_cezzis[0].id,
  ] : []

  cache {
    query_string_caching_behavior = "IgnoreQueryString"
    compression_enabled           = true
    content_types_to_compress = [
      "application/javascript",
      "application/json",
      "application/xml",
      "application/x-javascript",
      "image/svg+xml",
      "text/css",
      "text/html",
      "text/javascript",
      "text/plain",
      "text/xml",
    ]
  }
}