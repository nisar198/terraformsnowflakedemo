
resource "snowflake_role" "db_role" {
  name     = "TF_DEMO_WR"
  comment  = "my db role"
}

resource "snowflake_role_grants" "db_wr_grants"{
  role_name = snowflake_role.db_role.name
  users     = ["NISAR"] 
}

resource "snowflake_database_grant" "database_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  privilege = "USAGE"
  roles     = ["TF_DEMO_WR"]
}

resource "snowflake_schema_grant" "schema_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name
  privilege = "USAGE"
  roles     = ["TF_DEMO_WR"]
}

resource "snowflake_table_grant" "table_wr_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_WR"]

  on_future         = true
  with_grant_option = false
  #on_all            = false
}


resource "snowflake_view_grant" "view_ro_grant" {
  database_name = snowflake_database.tf_demo.name
  schema_name   = snowflake_schema.tf_schema.name

  privilege = "SELECT"
  roles     = ["TF_DEMO_WR"]

  on_future         = true
  with_grant_option = false
 # on_all            = false
}

resource "snowflake_warehouse_grant" "warehouse_grant" {
  warehouse_name = snowflake_warehouse.task_warehouse.name
  privilege      = "USAGE"
  roles          = ["TF_DEMO_WR"]
}