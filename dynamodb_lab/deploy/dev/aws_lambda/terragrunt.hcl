include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/tf_modules//aws_lambda"
}


inputs = {
  lambda_funcs = {
    "source_fake" = {
      handle_func   = "source_fake.handle_event"
      src_dir       = "${get_repo_root()}/dynamodb_lab/lambda/source_fake"
      output_path   = "${get_repo_root()}/dynamodb_lab/artifacts/source_fake.zip"
      event_map     = false
      event_src_arn = "abc"
    },
    "dynamodb_ingest" = {
      handle_func   = "dynamodb_ingest.handle_event"
      src_dir       = "${get_repo_root()}/dynamodb_lab/lambda/dynamodb_ingest"
      output_path   = "${get_repo_root()}/dynamodb_lab/artifacts/dynamodb_ingest.zip1"
      event_map     = false
      event_src_arn = "abc"
    },
    "kdf_transform" = {
      handle_func   = "kdf_transform.handle_event"
      src_dir       = "${get_repo_root()}/dynamodb_lab/lambda/kdf_transform"
      output_path   = "${get_repo_root()}/dynamodb_lab/artifacts/kdf_transform.zip"
      event_map     = false
      event_src_arn = "abc"
    }
  }
}