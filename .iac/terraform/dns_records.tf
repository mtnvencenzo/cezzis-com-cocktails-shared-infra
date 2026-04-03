# =====================================================
# CNAME RECORD FOR AUTH0 CUSTOM DOMAIN login.cezzis.com
# =====================================================
module "login_cname_record" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-sub-domain-record"

  dns_zone = {
    resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
    name                = data.azurerm_dns_zone.cezzis_dns_zone.name
  }

  ttl                           = 300
  sub_domain                    = var.auth0_custom_domain_subdomain
  record_fqdn                   = var.auth0_custom_domain_cname
  custom_domain_verification_id = "random-string" # Not used for CNAME but required by module interface

  tags = local.tags
}



# ================================
# MX MAIL RECORD
# ================================
module "cocktails_dns_zoho_mx_record" {
  source             = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-mx-record"
  count              = var.include_zoho_mx_dns_records == true ? 1 : 0
  spf_include_domain = "zohomail.com"

  tags = local.tags

  providers = {
    azurerm = azurerm
  }

  dns_zone = {
    name                = data.azurerm_dns_zone.cezzis_dns_zone.name
    resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  }

  dkim_record = {
    name  = "zmail._domainkey"
    value = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCTnZHS1lvmFKKGwS+Aba20XZqeZM+STKdyRTltks2qvVRhNop4GeCdcXr8lc/cue3mV/48CchHQxqX30y3glRhB5z0xQOB4+dOl3z4buJa0fvqYxjOrurNn2yF06zx5hSB02eO9Q82p4AMT6BG0ApDGMxxhQ4sGl99A251eFMcgQIDAQAB"
  }

  record_exchanges = [
    {
      preference = 10
      exchange   = "mx.zoho.com"
    },
    {
      preference = 20
      exchange   = "mx2.zoho.com"
    },
    {
      preference = 50
      exchange   = "mx3.zoho.com"
    }
  ]
}

# =====================================================
# FRONT DOOR CUSTOM DOMAIN DNS VALIDATION RECORDS
# =====================================================

resource "azurerm_dns_txt_record" "frontdoor_apex_validation" {
  count               = var.include_apex_domain_records ? 1 : 0
  name                = "_dnsauth"
  zone_name           = data.azurerm_dns_zone.cezzis_dns_zone.name
  resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  ttl                 = 3600
  tags                = local.tags

  record {
    value = azurerm_cdn_frontdoor_custom_domain.apex_cezzis[0].validation_token
  }
}

resource "azurerm_dns_txt_record" "frontdoor_www_validation" {
  count               = var.include_apex_domain_records ? 1 : 0
  name                = "_dnsauth.www"
  zone_name           = data.azurerm_dns_zone.cezzis_dns_zone.name
  resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  ttl                 = 3600
  tags                = local.tags

  record {
    value = azurerm_cdn_frontdoor_custom_domain.www_cezzis[0].validation_token
  }
}

# =====================================================
# FRONT DOOR DNS ROUTING RECORDS
# =====================================================

resource "azurerm_dns_cname_record" "www_frontdoor" {
  count               = var.include_apex_domain_records ? 1 : 0
  name                = "www"
  zone_name           = data.azurerm_dns_zone.cezzis_dns_zone.name
  resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  ttl                 = 300
  record              = data.azurerm_cdn_frontdoor_endpoint.global_shared_cdn_endpoint.host_name
  tags                = local.tags
}

resource "azurerm_dns_a_record" "apex_frontdoor" {
  count               = var.include_apex_domain_records ? 1 : 0
  name                = "@"
  zone_name           = data.azurerm_dns_zone.cezzis_dns_zone.name
  resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  ttl                 = 300
  target_resource_id  = data.azurerm_cdn_frontdoor_endpoint.global_shared_cdn_endpoint.id
  tags                = local.tags
}

# ================================
# Google Site Verification
# ================================
module "cocktails_dns_google_site_verification_txt" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/dns-txt-record"
  count  = var.include_google_verification_txt_record == true ? 1 : 0
  name   = "google-site-verification"
  value  = "google-site-verification=w4YM0OPjGK14u7y6xPLc4w5TW6k3U2V3YLsY5cI0paQ"

  tags = local.tags

  dns_zone = {
    name                = data.azurerm_dns_zone.cezzis_dns_zone.name
    resource_group_name = data.azurerm_dns_zone.cezzis_dns_zone.resource_group_name
  }

  providers = {
    azurerm = azurerm
  }
}
