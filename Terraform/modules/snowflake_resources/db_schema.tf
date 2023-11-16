
provider "snowflake" {
  alias = "account_admin" 
  user     = "nisar"  
  password = "N15ar198#?"
  account  = "wytnjkv-jj20993" 
  role     = "ACCOUNTADMIN"
  #private_key = var.snowflake_private_key
}
resource "snowflake_database" "accounts_transactions" {
  provider = snowflake.sysadmin
  name                        = var.database
  data_retention_time_in_days = var.time_travel_in_days
}

resource "snowflake_schema" "stage" {
  provider = snowflake.sysadmin
  database = snowflake_database.accounts_transactions.name
  name     = "STAGE"
}
resource "snowflake_schema" "core" {
  provider = snowflake.sysadmin
  database = snowflake_database.accounts_transactions.name
  name     = "CORE"
}
resource "snowflake_schema" "dataset" {
  provider = snowflake.sysadmin
  database = snowflake_database.accounts_transactions.name
  name     = "DATASET"
}