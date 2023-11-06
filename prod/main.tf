terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.75.0"
    }
  }

  backend "s3" {
    bucket = "awsterraformdemo123"
    key    = "terraform-staging-demo.tfstate"
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
  account  = "ctlmpro-dn83635"
  role     = "ACCOUNTADMIN"
  #private_key = var.snowflake_private_key
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = var.time_travel_in_days
  database            = var.database
  env_name            = var.env_name
}
 