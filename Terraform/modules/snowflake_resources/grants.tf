provider "snowflake" {
  alias = "user_admin" 
  user     = "nisar"  
  password = "N15ar198#?"
  account  = "wytnjkv-jj20993" 
  role     = "USERADMIN"
  #private_key = var.snowflake_private_key
}
resource "snowflake_role" "functional_domain_readonly" { 
  provider = snowflake.user_admin 
  name     = var.functional_domain_accounts_transactions
  comment  = "snowflake function domain role example : ACCOUNTS_TRANSACTIONS read only"
}

resource "snowflake_role" "functional_domain_supper_user" { 
  provider = snowflake.user_admin
  name     = var.functional_domain_accounts_transactions_pu
  comment  = "snowflake function domain role power user, example ACCOUNTS_TRANSACTIONS_pu"
}

resource "snowflake_role" "developer" { 
  provider = snowflake.user_admin 
  name     = var.functional_role_developer
  comment  = "snowflake functional developer role"
}

resource "snowflake_role" "analyst" { 
  provider = snowflake.user_admin 
  name     = var.functional_role_analyst
  comment  = "snowflake functional analyst role"
}

resource "snowflake_role" "data_scientist" {
  provider = snowflake.user_admin  
  name     = var.functional_role_data_scientist
  comment  = "snowflake functional data_scientist role"
}

resource "snowflake_role" "end_user" {
  provider = snowflake.user_admin  
  name     = var.functional_role_end_user
  comment  = "snowflake functional end_user role"
}


# grant functional domain role to sysadmin
resource "snowflake_role_grants" "functiondomain_ro_to_syadmin" {
  provider = snowflake.user_admin
  role_name = snowflake_role.functional_domain_readonly.name

  roles = [
     "SYSADMIN",
  ]  
}

resource "snowflake_role_grants" "functiondomain_su_to_syadmin" {
  provider = snowflake.user_admin
  role_name = snowflake_role.functional_domain_supper_user.name

  roles = [
     "SYSADMIN",
  ]  
}

# grant functional role to sysadmin
resource "snowflake_role_grants" "syadmin_to_developer" {
  provider = snowflake.account_admin
  role_name = "SYSADMIN"

  roles = [
     snowflake_role.developer.name,
  ]  
}

resource "snowflake_role_grants" "analyst_to_syadmin" {
  provider = snowflake.user_admin
  role_name = snowflake_role.analyst.name

  roles = [
     "SYSADMIN",
  ]  
}

resource "snowflake_role_grants" "data_scientist_to_syadmin" {
  provider = snowflake.user_admin
  role_name = snowflake_role.data_scientist.name

  roles = [
     "SYSADMIN",
  ]  
}

resource "snowflake_role_grants" "end_user_to_syadmin" {
  provider = snowflake.user_admin
  role_name = snowflake_role.end_user.name

  roles = [
     "SYSADMIN",
  ]  
}

#resource "snowflake_role_grants" "sysadmin_to_developer" {#
 # provider = snowflake.account_admin
  #role_name = "SYSADMIN"

  #roles = [
  #   snowflake_role.developer.name,
  #]  
#}


# create data access level roles
resource "snowflake_role" "access_level_stag_sr" {
  provider = snowflake.user_admin  
  name     = "ACCOUNTS_TRANSACTIONS_STAGE_SR"
  comment  = "access level role stage sr"
}



resource "snowflake_role" "access_level_core_sr" {

  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = "ACCOUNTS_TRANSACTIONS_CORE_SR"
  comment  = "access level role"
}

resource "snowflake_role" "access_level_dataset_sr" {
  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = "ACCOUNTS_TRANSACTIONS_DATASET_SR"
  comment  = "access level role"
}

resource "snowflake_role" "access_level_dataset_all" {
  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = "ACCOUNTS_TRANSACTIONS_DATASET_All"
  comment  = "access level role"
}

# stage_sr role to functional domain REAONLY roles e.g developer, data scientist
resource "snowflake_role_grants" "access_level_stag_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_stag_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}

resource "snowflake_role_grants" "access_level_core_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_core_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}

resource "snowflake_role_grants" "access_level_dataset_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_dataset_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name, snowflake_role.end_user.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}




# grant database usage to access level roles

resource "snowflake_database_grant" "database_wr_grant" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_stag_sr.name, snowflake_role.access_level_core_sr.name, 
  snowflake_role.access_level_dataset_sr.name, snowflake_role.access_level_dataset_all.name]
}

## grant schema usage to access level roles 
resource "snowflake_schema_grant" "to_stage" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_stag_sr.name]  
}

resource "snowflake_schema_grant" "to_core" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.core.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_core_sr.name ]  
}

resource "snowflake_schema_grant" "to_dataset" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.dataset.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_dataset_sr.name ]  
}

## grant select on all views and tabled

resource "snowflake_view_grant" "view_ro_grant_staging" {
  provider = snowflake.account_admin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name

  privilege = "SELECT"
  roles     = [snowflake_role.access_level_stag_sr.name, snowflake_role.access_level_core_sr.name, snowflake_role.access_level_dataset_sr.name, snowflake_role.access_level_dataset_all.name ]

  on_future         = true
  with_grant_option = false
  on_all            = false
}

resource "snowflake_table_grant" "table_ro_grant_to_access_level" {
  provider = snowflake.account_admin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name

  privilege = "SELECT"
  roles     = [snowflake_role.access_level_stag_sr.name, snowflake_role.access_level_core_sr.name, snowflake_role.access_level_dataset_sr.name, snowflake_role.access_level_dataset_all.name]
  on_future         = true
  with_grant_option = false
 # on_all            = false
}




resource "snowflake_warehouse_grant" "warehouse_grant" {
  provider = snowflake.sysadmin
  warehouse_name = snowflake_warehouse.task_warehouse.name
  privilege      = "USAGE"
  roles          = [snowflake_role.developer.name,snowflake_role.analyst.name,snowflake_role.data_scientist.name,snowflake_role.end_user.name]
}

resource "snowflake_role_grants" "db_wr_grants"{
  provider = snowflake.user_admin
  role_name = snowflake_role.analyst.name
  users     = ["NISAR"] 
}
resource "snowflake_role_grants" "db_wr_grantst_sr"{
  provider = snowflake.user_admin
  role_name = snowflake_role.developer.name
  users     = ["NISAR"] 
}