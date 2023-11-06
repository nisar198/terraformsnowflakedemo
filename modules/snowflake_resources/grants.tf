resource "snowflake_database_role" "db_role" {
  database = snowflake_database.tf_demo.name
  name     = "TF_DEMO_READER"
  comment  = "my db role"
}
resource "snowflake_role_grants" "demo_role_grants"{
    role_name= snowflake_database_role.db_role.name
    users = "NISAR"

}

resource "snowflake_database_grant" "database_ro_grant" {
  database_name = snowflake_database.tf_demo.name

  privilege = "USAGE"
  roles     = ["TF_DEMO_READER"]
}

resource "snowflake_schema_grant" "schema_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "USAGE"
  roles     = ["TF_DEMO_READER"]
}

resource "snowflake_table_grant" "table_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_READER"]

  on_future         = true
  with_grant_option = false
  #on_all            = false
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
  roles          = ["TF_DEMO_READER"]
}