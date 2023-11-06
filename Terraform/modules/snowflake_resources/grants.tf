resource "snowflake_database_role" "db_role" {
  database = snowflake_database.tf_demo.name
  name     = "TF_DEMO_READER"
  comment  = "my db role"
}

resource "snowflake_database_role" "db_role_wr" {
  database = snowflake_database.tf_demo.name
  name     = "TF_DEMO_WR"
  comment  = "my db role WR"
}


resource "snowflake_role_grants" "demo_role_grants" {
  role_name = snowflake_database_role.db_role.name

  roles = [
    snowflake_database_role.db_role_wr.name, 
  ]

  users = [
    "NISAR"
  ]
}

resource "snowflake_database_grant" "database_ro_grant" {
  database_name = snowflake_database.tf_demo.name

  privilege = "USAGE"
  roles     = ["TF_DEMO_READER", "TF_DEMO_WR"]
}

resource "snowflake_schema_grant" "schema_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "USAGE"
  roles     = ["TF_DEMO_READER", "TF_DEMO_WR"]
}

resource "snowflake_table_grant" "table_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_READER", "TF_DEMO_WR"]

  on_future         = true
  with_grant_option = false
  #on_all            = false
}


resource "snowflake_grant_privileges_to_role" "table_wr_grant" {
  privileges = ["MODIFY", "CREATE TABLE"]
  role_name  = snowflake_database_role.db_role_wr.name
  on_schema {
    schema_name = "\"TF_DEMO_STAGING\".\"TF_DEMO\"" # note this is a fully qualified name!
  }
}

resource "snowflake_view_grant" "view_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_READER"]

  on_future         = true
  with_grant_option = false
 # on_all            = false
}

resource "snowflake_warehouse_grant" "warehouse_grant" {
  warehouse_name = snowflake_warehouse.task_warehouse.name
  privilege      = "USAGE"
  roles          = ["TF_DEMO_READER", "TF_DEMO_WR"]
}