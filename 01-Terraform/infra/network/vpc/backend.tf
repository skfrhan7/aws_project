terraform {
backend "s3" {
    bucket = "aws05-terraform-state"
    key = "infra/network/vpc/terrafrom.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "aws05-terraform-locks"
    encrypt = true
 }
}
