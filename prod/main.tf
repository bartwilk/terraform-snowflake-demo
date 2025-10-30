terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.66.2"
    }
  }

  backend "gcs" {
    bucket = "tf-state-bucket10001"
    prefix = "prod" # state stored at gs://<bucket>/prod/<workspace>.tfstate
    # optional:
    # impersonate_service_account = "terraform@YOUR_PROJECT_ID.iam.gserviceaccount.com"
    # encryption_key             = "BASE64_32_BYTE_CUSTOMER_SUPPLIED_KEY"
  }
}

provider "snowflake" {
  username               = "BARTWILK"
  account                = "BMPXPNG-PDB39891"
  role                   = "ACCOUNTADMIN"
  private_key            = var.snowflake_private_key
  private_key_passphrase = var.snowflake_private_key_passphrase
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 30
  database            = var.database
  env_name            = var.env_name
}