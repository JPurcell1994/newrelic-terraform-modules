provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "newrelic_alert_policy" "elasticsearch" {
  name = var.alert_policy_name
}

resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  policy_id   = newrelic_alert_policy.elasticsearch.id
  channel_ids = [data.newrelic_alert_channel.alert_channel.id]
}

data "newrelic_alert_channel" "alert_channel" {
  name = var.newrelic_channel_name
}

resource "newrelic_infra_alert_condition" "elasticsearch_red_status" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch Red Status"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.ClusterStatus.red.Minimum"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 30
    value         = 0
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_min_storage" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch Min Storage"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.FreeStorageSpace.Minimum"
  comparison = "below"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 30
    value         = var.elasticsearch_min_storage_available
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_read_latency" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch Read Latency"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.ReadLatency.Average"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 5
    value         = var.elasticsearch_read_latency_threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_write_latency" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch Write Latency"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.WriteLatency.Average"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 5
    value         = var.elasticsearch_write_latency_threshold
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_5XX_response" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch 5XX Response"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.5xx.Sum"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 5
    value         = 1
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_CPU_utilisation" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch CPU Utilisation"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.CPUUtilization.Average"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 5
    value         = 90
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "elasticsearch_JVM_mem_pressure" {
  policy_id = newrelic_alert_policy.elasticsearch.id

  name       = "ElasticSearch JVM Memory Pressure"
  runbook_url = var.runbook_url
  type       = "infra_metric"
  event      = "DatastoreSample"
  select     = "provider.JVMMemoryPressure.Maximum"
  comparison = "above"
  integration_provider = "ElasticsearchCluster"

  critical {
    duration      = 5
    value         = 90
    time_function = "all"
  }
}


// To-Do
// Per ElasticSearch
// Alert on , red cluster status, min storage, read and write latency, 5XX resp codes, CPU/Mem usage