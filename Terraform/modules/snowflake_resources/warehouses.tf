resource "snowflake_warehouse" "task_warehouse" {
  name           = var.env_name == "PROD" ? "DEMO_TASK_WAREHOUSE" : "DEMO_TASK_WAREHOUSE_${var.env_name}"
  warehouse_size = var.env_name == "PROD" ? "LARGE" : "SMALL"
  auto_resume    = true
  auto_suspend   = 1
}
