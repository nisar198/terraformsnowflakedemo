variable "database" {
  type    = string
  default = "TF_DEMO_STAGING"
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