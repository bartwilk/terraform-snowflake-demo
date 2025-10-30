variable "database" {
  type    = string
  default = "TERRAFORM_DEMO_PROD"
}

variable "env_name" {
  type    = string
  default = "PROD"
}

variable "gcs_bucket" {
  type        = string
  description = "Bucket used in GCS"
  sensitive   = true
}

variable "snowflake_private_key" {
  type        = string
  description = "Private key used to access Snowflake"
  sensitive   = true
}

variable "snowflake_private_key_passphrase" {
  type        = string
  description = "Passphrase used to access Snowflake"
  sensitive   = true
}

variable "snowflake_username" {
  type        = string
  description = "Username used to access Snowflake"
  sensitive   = true
}

variable "snowflake_account" {
  type        = string
  description = "Account ID used to access Snowflake"
  sensitive   = true
}

variable "snowflake_role" {
  type        = string
  description = "Role ID used to access Snowflake"
  sensitive   = true
}
