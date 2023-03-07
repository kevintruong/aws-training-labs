include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/tf_modules//aws_kinesis_firehose"
}

dependency "kinesis-stream" {
  config_path = "../aws_kinesis_data_stream"
}

inputs = {
  kdf_list = {
    "BackupStream" = {
      kds = dependency.kinesis-stream.outputs.kds_stream["BackupStream"]
    }
  }
}