provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "newrelic_alert_policy" "rds" {
  name = "rds-alert-policy-ntm"
}

resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  policy_id   = newrelic_alert_policy.rds.id
  channel_ids = [data.newrelic_alert_channel.alert_channel.id]
}

data "newrelic_alert_channel" "alert_channel" {
  name = var.newrelic_channel_name
}

resource "newrelic_infra_alert_condition" "rds_cpu_utilisation" {
  policy_id = newrelic_alert_policy.rds.id

  name       = "RDS CPU Utilisation"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.cpuUtilization.Average"
  comparison = "above"
  integration_provider = "RdsDbInstance"

  critical {
    duration      = 5
    value         = 90
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "rds_read_latency" {
  policy_id = newrelic_alert_policy.rds.id

  name       = "RDS Read Latency"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.readLatency.Maximum"
  comparison = "above"
  integration_provider = "RdsDbInstance"

  critical {
    duration      = 5
    value         = var.rds_read_latency_threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "rds_write_latency" {
  policy_id = newrelic_alert_policy.rds.id

  name       = "RDS Write Latency"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.writeLatency.Maximum"
  comparison = "above"
  integration_provider = "RdsDbInstance"

  critical {
    duration      = 5
    value         = var.rds_write_latency_threshold
    time_function = "all"
  }
}