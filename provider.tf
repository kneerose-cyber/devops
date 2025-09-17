## uncomment after bucket and table is created
#terraform {
#  backend "s3" {
#    bucket = "s3statebackedn43678"
#    dynamodb_table = "state-lock"
#    key    = "global/mystatefile/terraform.tfstate"
#    region = "us-east-1"
#    encrypt = true
#  }
#}
provider "aws" {
   region = "us-east-1"
   
}
