resource "snowflake_role" "db_role_wr" {  
  name     = var.dbr_role_wr
  comment  = "my db role"
}

resource "snowflake_role_grants" "db_wr_grants"{
  role_name = snowflake_role.db_role_wr.name
  users     = ["NISAR"] 
}

resource "snowflake_database_grant" "database_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  privilege = "USAGE"
  roles     = ["TF_DEMO_WR_STAGING"]
}

resource "snowflake_schema_grant" "schema_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name
  privilege = "USAGE"
  roles     = ["TF_DEMO_WR_STAGING"]
}


resource "snowflake_table_grant" "table_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_WR_STAGING"]

  on_future         = true
  with_grant_option = false
  #on_all            = false
}

resource "snowflake_table_grant" "table_wr_grant_create_table" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "ALL PRIVILEGES"
  roles     = ["TF_DEMO_WR_STAGING"]

  on_future         = true
  with_grant_option = false
  #on_all            = false
}


resource "snowflake_view_grant" "view_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_WR_STAGING"]

  on_future         = true
  with_grant_option = false
 # on_all            = false
}

resource "snowflake_warehouse_grant" "warehouse_grant" {
  warehouse_name = snowflake_warehouse.task_warehouse.name
  privilege      = "USAGE"
  roles          = ["TF_DEMO_WR_STAGING"]
}