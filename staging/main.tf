terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.63.0"
    }
  }

 backend "gcs" {
    bucket = "tf-state-bucket10001"
    prefix = "staging"
  }
}

provider "snowflake" {
  username    = "BARTWILK"
  account     = "BMPXPNG-PDB39891"
  role        = "ACCOUNTADMIN"
  private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 1
  database            = var.database
  env_name            = var.env_name
}