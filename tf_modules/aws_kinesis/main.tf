variable "kds_list" {
  type = map(object({
    shard_count      = number
    retention_period = number
    stream_mode      = string
  }))
}


resource "aws_kinesis_stream" "test_stream" {
  for_each         = {for kds_name, kds_cfg in var.kds_list : kds_name=> kds_cfg}
  name             = each.key
  shard_count      = each.value.shard_count
  retention_period = each.value.retention_period

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = each.value.stream_mode
  }

  tags = {
    Environment = "test"
  }
}