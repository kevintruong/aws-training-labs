resource "aws_dynamodb_table" "basic-dynamodb-table" {
  for_each     = {for table, table_cfg in var.dynamodb_table_list : table => table_cfg}
  name         = each.key #"StateTable"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "TradeId"

  attribute {
    name = "TradeId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }

  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
}

resource "aws_dynamodb_kinesis_streaming_destination" "example" {
  for_each   = {for func_name, func_cfg in var.dynamodb_table_list : func_name=> func_cfg if func_cfg.stream_enable}
  stream_arn = each.value.stream_arn
  table_name = aws_dynamodb_table.basic-dynamodb-table[each.key].name
}
