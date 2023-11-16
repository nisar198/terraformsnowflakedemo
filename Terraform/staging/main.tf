terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.75.0"
    }
  }
  backend "s3" {
    bucket = "awsterraformdemo123"
    key    = "terraform-staging1.tfstate"
    region = "eu-north-1"
    # Optional DynamoDB for state locking. See https://developer.hashicorp.com/terraform/language/settings/backends/s3 for details.
    # dynamodb_table = "terraform-state-lock-table"
    encrypt = true
    # role_arn       = "arn:aws:iam::047366754860:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing"
  }

}


provider "snowflake" {

  user     = "nisar"
  password = "N15ar198#?"
  account  = "wytnjkv-jj20993"
  role     = "SYSADMIN"
  #private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source                                     = "../modules/snowflake_resources"
  time_travel_in_days                        = var.time_travel_in_days
  database                                   = var.database
  env_name                                   = var.env_name
  functional_role_developer                  = var.functional_role_developer
  functional_role_analyst                    = var.functional_role_analyst
  functional_role_end_user                   = var.functional_role_end_user
  functional_role_data_scientist             = var.functional_role_data_scientist
  functional_domain_accounts_transactions    = var.functional_domain_accounts_transactions
  functional_domain_accounts_transactions_pu = var.functional_domain_accounts_transactions_pu
}