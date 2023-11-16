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
  default = "SNOWFLAKE_DEVELOPER_STG"
}

variable "functional_role_analyst" {
  type    = string
  default = "SNOWFLAKE_ANALYST_STAG"
}

variable "functional_role_end_user" {
  type    = string
  default = "SNOWFLAKE_END_USER_STG"
}

variable "functional_role_data_scientist" {
  type    = string
  default = "SNOWFLAKE_DATA_SCIENTIST_STG"
}

variable "functional_domain_accounts_transactions" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_STG"
}

variable "functional_domain_accounts_transactions_pu" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_PU_STG"
}


variable "access_level_staging_sr" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_STAGE_SR_STG"
}

variable "access_level_core_sr" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_CORE_SR_STG"
}

variable "access_level_dataset_sr" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_DATASET_SR_STG"
}

variable "access_level_dataset_all" {
  type    = string
  default = "ACCOUNTS_TRANSACTIONS_DATASET_All_STG"
}
