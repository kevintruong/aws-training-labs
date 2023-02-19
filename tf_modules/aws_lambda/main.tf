resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_func_src" {
  for_each = {
  for key, value in var.lambda_funcs :
  key => value
  }
  output_path = each.value.output_path
  source_dir  = each.value.src_dir
  type        = "zip"
}


resource "aws_s3_bucket" "lambda_artifact_bucket" {
  bucket = "vutch-lambda-artifacts"
}

resource "aws_s3_bucket_object" "lambda_example" {
  depends_on = [aws_s3_bucket.lambda_artifact_bucket]
  for_each   = {for func_name, func_cfg in var.lambda_funcs : func_name => func_cfg}
  source     = data.archive_file.lambda_func_src[each.key].output_path
  etag       = data.archive_file.lambda_func_src[each.key].output_md5
  bucket     = aws_s3_bucket.lambda_artifact_bucket.id
  key        = format("%s/%s", "lambda_artifacts", each.key)
}

resource "aws_lambda_function" "lambda_func" {
  depends_on = [
    aws_s3_bucket_object.lambda_example,
    aws_s3_bucket.lambda_artifact_bucket
  ]
  for_each      = {for func_name, func_cfg in var.lambda_funcs : func_name=> func_cfg}
  function_name = each.key
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = format("%s.%s", each.key, "event_handler")
  s3_bucket     = aws_s3_bucket.lambda_artifact_bucket.id
  s3_key        = aws_s3_bucket_object.lambda_example[each.key].id
  runtime       = "python3.8"
}

output "lambda_func_s3_key" {
  value = [for each in aws_s3_bucket_object.lambda_example : each.id]
}
