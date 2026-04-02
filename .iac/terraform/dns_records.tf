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
