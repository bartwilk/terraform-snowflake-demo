terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.66.2"
    }
  }

  backend "gcs" {
    # bucket = "tf-state-bucket10001"
    bucket = var.gcs_bucket
    prefix = "prod"
  }
}

provider "snowflake" {
  username               = var.snowflake_username
  account                = var.snowflake_account
  role                   = var.snowflake_role
  private_key            = var.snowflake_private_key
  private_key_passphrase = var.snowflake_private_key_passphrase
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 30
  database            = var.database
  env_name            = var.env_name
}