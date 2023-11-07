resource "snowflake_table" "demo_table" {
  database   = snowflake_database.tf_demo.name
  schema     = snowflake_schema.tf_schema.name
  depends_on = [snowflake_table_grant.table_wr_grant_create_table]
  name       = "DEMO_TABLE"
  comment    = "An empty table for Terraform demo"

  column {
    name     = "id"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "data"
    type     = "text"
    nullable = false
  }

  column {
    name = "DATE"
    type = "TIMESTAMP_NTZ(9)"
  }
}