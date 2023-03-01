resource "aws_kinesis_stream" "test_stream" {
  for_each         = {for kds_name, kds_cfg in var.kds_list : kds_name=> kds_cfg}
  name             = each.key
  shard_count      = each.value.shard_count
  retention_period = each.value.retention_period

  stream_mode_details {
    stream_mode = each.value.stream_mode
  }

  tags = {
    Environment = "test"
  }
}