# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "aws-training-vutch"
    dynamodb_table = "tf-locks"
    encrypt        = true
    key            = "aws_kinesis_data_firehose/output/terraform.tfstate"
    region         = "ap-southeast-1"
  }
}
