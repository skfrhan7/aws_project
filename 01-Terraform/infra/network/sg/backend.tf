terraform {
backend "s3" {
    bucket = "aws05-terraform-state"
    key = "infra/network/sg/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "aws05-terraform-locks"
    encrypt = true
 }
}
