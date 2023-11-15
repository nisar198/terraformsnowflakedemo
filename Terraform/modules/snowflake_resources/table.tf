provider "snowflake" {
  alias = "sysadmin"
  user     = "nisar"
  password = "N15ar198#?"
  account  = "wytnjkv-jj20993"
  role     = "SYSADMIN"
  #private_key = var.snowflake_private_key
}
#resource "snowflake_table" "demo_table" {
  #provider = snowflake.sysadmin
  #database   = snowflake_database.accounts_transactions.name
  #schema     = snowflake_schema.stage.name
  #depends_on = [snowflake_table_grant.table_wr_grant_create_table]
  #name       = "DEMO_TABLE"
  #comment    = "An empty table for Terraform demo"

  #column {
    #name     = "id"
    #type     = "NUMBER(38,0)"
   # nullable = true
  #}

  #column {
    #name     = "data"
    #type     = "text"
   # nullable = false
  #}

  #column {
   # name = "DATE"
  #  type = "TIMESTAMP_NTZ(9)"
 # }
#}