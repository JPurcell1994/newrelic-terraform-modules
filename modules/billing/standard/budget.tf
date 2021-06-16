resource "aws_budgets_budget" "EC2" {
  name              = "Monthly EC2 Budget"
  budget_type       = "COST"
  limit_amount      = var.ec2_limit_amount
  limit_unit        = "USD"
  time_period_end   = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit         = "MONTHLY"

  cost_filters = {
    Service = "Amazon Elastic Compute Cloud - Compute"
  }

}

resource "aws_budgets_budget" "RDS" {
  name              = "Monthly RDS Budget"
  budget_type       = "COST"
  limit_amount      = var.rds_limit_amount
  limit_unit        = "USD"
  time_period_end   = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit         = "MONTHLY"

  cost_filters = {
    Service = "Amazon Relational Database Service"
  }

}

resource "aws_budgets_budget" "ElasticSearch" {
  name = "Monthly ElasticSearch Budget"
  budget_type = "COST"
  limit_amount = var.elasticsearch_limit_amount
  limit_unit = "USD"
  time_period_end = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit = "MONTHLY"

  cost_filters = {
    Service = "Amazon Elasticsearch Service"
  }
}

resource "aws_budgets_budget" "S3" {
  name = "Monthly S3 Budget"
  budget_type = "COST"
  limit_amount = var.s3_limit_amount
  limit_unit = "USD"
  time_period_end = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit = "MONTHLY"

  cost_filters = {
    Service = "Amazon Simple Storage Service"
  }
}

resource "aws_budgets_budget" "Total" {
  name              = "Monthly AWS Total Budget"
  budget_type       = "COST"
  limit_amount      = var.aws_total_limit_amount
  limit_unit        = "USD"
  time_period_end   = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit         = "MONTHLY"

}
