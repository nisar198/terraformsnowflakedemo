variable "database" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_STAGING"
}

variable "env_name" {
  type    = string
  default = "STAGING"
}

variable "time_travel_in_days" {
  type        = number
  description = "Number of days for time travel feature"
  default     = 1
}

variable "functional_role_developer" {
  type    = string
  default = "SNOWFLAKE_DEVELOPER"
}

variable "functional_role_analyst" {
  type    = string
  default = "SNOWFLAKE_ANALYST"
}

variable "functional_role_end_user" {
  type    = string
  default = "SNOWFLAKE_END_USER"
}

variable "functional_role_data_scientist" {
  type    = string
  default = "SNOWFLAKE_DATA_SCIENTIST"
}

variable "functional_domain_accounts_transactions" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS"
}

variable "functional_domain_accounts_transactions_pu" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_PU"
}


