variable "database" {
  type    = string
  default = "TF_DEMO"
}

variable "env_name" {
  type    = string
  default = "PROD"
}

variable "time_travel_in_days" {
  type        = number
  description = "Number of days for time travel feature"
  default=10
}

variable "dbr_role_wr" {
  type    = string
  default = "TF_DEMO_WR"
}

variable "dbr_role_ro" {
  type = string
  default = "TF_DEMO_RO"
}
