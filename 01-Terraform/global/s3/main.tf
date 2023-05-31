terraform {
	required_version = ">= 1.0.0, < 2.0.0"
	required_providers {
	
		aws 		= {
		source  = "hashicorp/aws"
		version = "~> 4.0"
 }
}
}
provider "aws" {
	region = "ap-northeast-2"
}

resource "aws_s3_bucket" "terraform_state" { 
	bucket 				= var.bucket_name
	
	
# true : 삭제 거부,false : 삭제 허용		
	lifecycle {
		prevent_destroy = false 
	}
	force_destroy = true
}
# 코드 이력을 관리하기 위해 상태 파일의 버전 관리를 활성화 한다	
resource"aws_s3_bucket_versioning" "enabled" {
	bucket = aws_s3_bucket.terraform_state.id
	versioning_configuration {
	status = "Enabled"
	}
}
#서버 측에서 암호화를 활성화 한다.
resource "aws_s3_bucket_server_side_encryption_configuration" "default"{
	bucket = aws_s3_bucket.terraform_state.id
		rule {
			apply_server_side_encryption_by_default {
				sse_algorithm = "AES256"
	 }
	} 
 }

#S3 버킷에 대한 모든 공용 액세스를 명시적으로 차단한다.
resource "aws_s3_bucket_public_access_block" "public_access" {
	bucket 									= aws_s3_bucket.terraform_state.id
	block_public_acls 			= true
	block_public_policy		  = true
	ignore_public_acls 			= true
	restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
		name 					= var.table_name
		billing_mode  = "PAY_PER_REQUEST"
		hash_key 			= "LockID"
		
		attribute {
		name 					= "LockID"
		type 					= "S"
  }
 } 


