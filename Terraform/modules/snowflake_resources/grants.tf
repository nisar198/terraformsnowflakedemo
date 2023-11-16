provider "snowflake" {
  alias = "user_admin" 
  user     = "nisar"  
  password = "N15ar198#?"
  account  = "wytnjkv-jj20993" 
  role     = "USERADMIN"
  #private_key = var.snowflake_private_key
}
#1 Functional role
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


#2 grant functional role to sysadmin
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


#3 create functional domain role 
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

#4 grant functional domain role to sysadmin
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


#5 create data access level role for each of the snowflake database schema
#5.1 create readod only role for the stage schema
resource "snowflake_role" "access_level_stag_sr" {
  provider = snowflake.user_admin  
  name     = var.access_level_staging_sr
  comment  = "access level role stage sr"
}


#5.2 create read only role for the core schema
resource "snowflake_role" "access_level_core_sr" {

  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = var.access_level_core_sr
  comment  = "access level role"
}

#5.3 create read only role for the dataset schema
resource "snowflake_role" "access_level_dataset_sr" {
  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = var.access_level_dataset_sr
  comment  = "access level role"
}

#5.4 create read write role for the dataset schema
resource "snowflake_role" "access_level_dataset_all" {
  provider = snowflake.user_admin
  #database = snowflake_database.accounts_transactions.name
  name     = var.access_level_dataset_all
  comment  = "access level role"
}


#6 stage_sr role to functional domain (and domain role) REAONLY roles e.g developer, data scientist
resource "snowflake_role_grants" "access_level_stag_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_stag_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}

#6.1 core readonly role to functional doamin and domain role)
resource "snowflake_role_grants" "access_level_core_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_core_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}

#6.2 dataset readonly role to functional doamin and domain role)
resource "snowflake_role_grants" "access_level_dataset_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_dataset_sr.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name, snowflake_role.end_user.name,
    snowflake_role.functional_domain_supper_user.name, snowflake_role.functional_domain_readonly.name,
  ]  
}

#6.3 dataset ALL role to only developer, data scientist and analyst functional role
resource "snowflake_role_grants" "access_level_dataset_all_to_function_domain" {
  provider = snowflake.user_admin
  role_name = snowflake_role.access_level_dataset_all.name

  roles = [
    snowflake_role.developer.name ,snowflake_role.data_scientist.name, snowflake_role.analyst.name,snowflake_role.functional_domain_supper_user.name
    ,
  ]  
}



#7 grant database usage to access level roles

resource "snowflake_database_grant" "database_wr_grant" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_stag_sr.name, snowflake_role.access_level_core_sr.name, 
  snowflake_role.access_level_dataset_sr.name, snowflake_role.access_level_dataset_all.name]
}

#8 grant schema usage to access level roles to thier own respective schema
#8.1 stage role to stage schema
resource "snowflake_schema_grant" "to_stage" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_stag_sr.name]  
}
#8.2 core role to core schema
resource "snowflake_schema_grant" "to_core" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.core.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_core_sr.name ]  
}

#8.3 dataset role to dataset schema usage
resource "snowflake_schema_grant" "to_dataset" {
  provider = snowflake.sysadmin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.dataset.name
  privilege = "USAGE"
  roles     = [snowflake_role.access_level_dataset_sr.name ]  
}

# 8.4 grant usage on warhouse to functional domain role
resource "snowflake_warehouse_grant" "warehouse_grant" {
  provider = snowflake.sysadmin
  warehouse_name = snowflake_warehouse.task_warehouse.name
  privilege      = "USAGE"
  roles          = [snowflake_role.developer.name,snowflake_role.analyst.name,snowflake_role.data_scientist.name,snowflake_role.end_user.name]
}

#9 grant select access level roles to the objects
#9.1 grant select  on all views in stage schema to stage_sr read only role
resource "snowflake_view_grant" "view_ro_grant_staging" {
  provider = snowflake.account_admin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name

  privilege = "SELECT"
  roles     = [snowflake_role.access_level_stag_sr.name]

  on_future         = true
  with_grant_option = false
  on_all            = false
}

#9.2 grant select on all table in stage schema to stage_sr read only role
resource "snowflake_table_grant" "table_ro_grant_to_stage_access_level" {
  provider = snowflake.account_admin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.stage.name

  privilege = "SELECT"
  roles     = [snowflake_role.access_level_stag_sr.name]
  #, snowflake_role.access_level_core_sr.name, snowflake_role.access_level_dataset_sr.name, snowflake_role.access_level_dataset_all.name]
  on_future         = true
  with_grant_option = false
 # on_all            = true
}


# grant all privillege on dataset schema to dataset all role
resource "snowflake_table_grant" "table_all_grant_to_access_level" {
  provider = snowflake.account_admin
  database_name = snowflake_database.accounts_transactions.name
  schema_name   = snowflake_schema.dataset.name 

  privilege = "ALL PRIVILEGES"
  roles     = [snowflake_role.access_level_dataset_all.name]
  on_future         = true
  with_grant_option = false
  #on_all            = true
}



#resource "snowflake_user" "user_analyst" {
 # provider = snowflake.account_admin
  #name         = "ANALYST_USER"
  #password     = "nisar198"
  
#}

#resource "snowflake_user" "user_developer" {
  #provider = snowflake.account_admin
  #name         = "DEVELOPER_USER"
  #password     = "nisar198"
  
#}

#resource "snowflake_role_grants" "db_wr_grants"{
 # provider = snowflake.user_admin
  #role_name = snowflake_role.analyst.name
  #users     = ["ANALYST_USER"] 
#}

#resource "snowflake_role_grants" "db_wr_DEVELOP_grants"{
 # provider = snowflake.user_admin
  #role_name = snowflake_role.developer.name
  #users     = ["DEVELOPER_USER"] 
#}



