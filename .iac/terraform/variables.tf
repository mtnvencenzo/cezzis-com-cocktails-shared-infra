variable "domain" {
  type        = string
  description = "Domain name. Use only lowercase letters and numbers"
  default     = "cocktails"
}

variable "owner" {
  type    = string
  default = "cocktails.shared"
}

variable "product" {
  type    = string
  default = "cezzis"
}

variable "shortdomain" {
  type        = string
  description = "Short domain name. Use only lowercase letters and numbers"
  default     = "cockti"
}

variable "environment" {
  type        = string
  description = "Environment name, e.g. 'dev' or 'stg' or 'prd'"
}

variable "region" {
  type    = string
  default = "eus"
}

variable "sub" {
  type        = string
  description = "Subscription short identitifer to be used in resource naming"
  default     = "vec"
}

variable "sequence" {
  type        = string
  description = "The sequence number of the resource typically starting with 001"
  default     = "001"
}

variable "short_sequence" {
  type        = string
  description = "The short sequence number of the resource typically starting with 1"
  default     = "1"
}

variable "global_environment" {
  type        = string
  description = "The global environment name"
  default     = "glo"
}

variable "allowed_origins" {
  type    = list(string)
  default = []
}

variable "cezzis_platform_onprem_service_principal_object_id" {
  type        = string
  description = "The object ID of the Cezzis Platform On-Premises service principal"
}

variable "include_zoho_mx_dns_records" {
  type    = bool
  default = false
}

variable "include_apex_domain_records" {
  type    = bool
  default = false
}

variable "include_google_verification_txt_record" {
  type    = bool
  default = false
}
