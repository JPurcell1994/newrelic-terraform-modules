resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  policy_id  = newrelic_alert_policy.apm_policy.id
  channel_ids = [data.newrelic_alert_channel.alert_channel.id]
}

data "newrelic_alert_channel" "alert_channel" {
  name = var.newrelic_channel_name
}

resource "newrelic_alert_policy" "apm_policy" {
  name = "${var.apm_application_name}-policy-ntm"
}


resource "newrelic_alert_condition" "response_time_alert" {

  enabled = var.enable_responsetime_alert

  policy_id = newrelic_alert_policy.apm_policy.id

  name        = "${var.apm_application_name}-responsetime-condition"
  type        = "apm_app_metric"
  entities    = [data.newrelic_entity.apm_application.application_id]
  metric      = "response_time_web"
  runbook_url = var.runbook_url
  condition_scope = "application"

  term {
    duration      = 5
    operator      = "above"
    priority      = "critical"
    threshold     = var.responsetime_threshhold
    time_function = "all"
  }
}

resource "newrelic_alert_condition" "error_condition_alert" {

  enabled = var.enable_error_alert

  policy_id = newrelic_alert_policy.apm_policy.id

  name        = "${var.apm_application_name}-error-condition"
  type        = "apm_app_metric"
  entities    = [data.newrelic_entity.apm_application.application_id]
  metric      = "error_percentage"
  runbook_url = var.runbook_url
  condition_scope = "application"

  term {
    duration      = 5
    operator      = "above"
    priority      = "critical"
    threshold     = "0"
    time_function = "all"
  }
}

resource "newrelic_alert_condition" "apdex_alert" {

  enabled = var.enable_apdex_alert

  policy_id = newrelic_alert_policy.apm_policy.id

  name        = "${var.apm_application_name}-apdex-condition"
  type        = "apm_app_metric"
  entities    = [data.newrelic_entity.apm_application.application_id]
  metric      = "apdex"
  runbook_url = var.runbook_url
  condition_scope = "application"

  term {
    duration      = 5
    operator      = "below"
    priority      = "warning"
    threshold     = "1"
    time_function = "all"
  }

  term {
    duration      = 5
    operator      = "below"
    priority      = "critical"
    threshold     = "0.9"
    time_function = "all"
  }
}

resource "newrelic_nrql_alert_condition" "cpu_alert" {
  policy_id = newrelic_alert_policy.apm_policy.id

  name        = "cpu limit"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = false

  critical {
    threshold_duration = 300
    operator      = "above"
    threshold     = "90"
    threshold_occurrences = "all"
  }

  nrql {
    query             = "FROM K8sContainerSample SELECT latest(cpuUsedCores / cpuLimitCores) * 100 as '% CPU' WHERE containerName like '${var.container_name}' and clusterName like '${var.eks_cluster_name}'"
    evaluation_offset = "5"
  }

  value_function               = "single_value"
  violation_time_limit_seconds = 3600
}

resource "newrelic_nrql_alert_condition" "mem_alert" {
  policy_id = newrelic_alert_policy.apm_policy.id

  name        = "mem limit"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = false

  critical {
    threshold_duration    = 300
    operator              = "above"
    threshold             = "90"
    threshold_occurrences = "all"
  }

  nrql {
    query             = "FROM K8sContainerSample SELECT latest(memoryUsedBytes / memoryLimitBytes) * 100 as '% CPU' WHERE containerName like '${var.container_name}' and clusterName like '${var.eks_cluster_name}'"
    evaluation_offset = "5"
  }

  value_function               = "single_value"
  violation_time_limit_seconds = 3600
}