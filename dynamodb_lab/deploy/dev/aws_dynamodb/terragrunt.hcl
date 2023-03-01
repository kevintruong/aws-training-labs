include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/tf_modules//aws_dynamodb"
}
