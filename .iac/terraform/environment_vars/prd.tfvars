environment = "prd"

allowed_origins = [
  "https://login.cezzis.com",
  "https://www.cezzis.com",
  "https://cezzis.com",
  "https://localhost:4001",
  "https://localhost:4000"
]

cezzis_platform_onprem_service_principal_object_id = "c073fb3b-6327-4e14-b514-2371b0aff26c"

include_zoho_mx_dns_records            = true
include_apex_domain_records            = true
include_google_verification_txt_record = true

auth0_custom_domain_cname     = "cezzis-cd-skhnnuczfndoqumy.edge.tenants.us.auth0.com"
auth0_custom_domain_subdomain = "login"