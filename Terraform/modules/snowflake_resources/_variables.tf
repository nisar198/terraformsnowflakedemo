variable "database" {
  type = string
}

variable "env_name" {
  type = string
}

variable "time_travel_in_days" {
  type        = number
  description = "Number of days for time travel feature"
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
  
}

variable "functional_role_data_scientist" {
  type    = string
  
}

variable "functional_domain_accounts_transactions" {
  type    = string
  
}

variable "functional_domain_accounts_transactions_pu" {
  type    = string
  
}


variable "access_level_staging_sr" {
  type    = string  
}

variable "access_level_core_sr" {
  type    = string  
}

variable "access_level_dataset_sr" {
  type    = string
}

variable "access_level_dataset_all" {
  type    = string  
}