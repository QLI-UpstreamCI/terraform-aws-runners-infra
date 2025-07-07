data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_vpc" "lambda_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.lambda_vpc_name != "" ? var.lambda_vpc_name : var.vpc_name]
  }
}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = var.subnet_names
  }
}

data "aws_subnets" "lambda_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lambda_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = var.lambda_subnet_names
  }
}

resource "aws_security_group" "lambda_sg" {
  # Only create the security group if it will be attached to a VPC
  count = (length(var.lambda_subnet_names) != 0) ? 1 : 0

  name        = "${var.resource_name_prefix}-lambda-sg"
  description = "Security group that provides access to the lambda functions to the internet and resources in the VPC (only when a VPC is attached)"
  vpc_id      = data.aws_vpc.lambda_vpc.id
  tags        = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  count = (length(var.lambda_subnet_names) != 0) ? 1 : 0

  security_group_id = aws_security_group.lambda_sg[0].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  count = (length(var.lambda_subnet_names) != 0) ? 1 : 0

  security_group_id = aws_security_group.lambda_sg[0].id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}
