terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.75.0"
    }
  }
}

provider "snowflake" {
  user = "nisar"
  password = "N15ar198#?"
  account  = "ctlmpro-dn83635"
  role     = "ACCOUNTADMIN"
  #private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = var.time_travel_in_days
  database            = var.database
  env_name            = var.env_name
}
 