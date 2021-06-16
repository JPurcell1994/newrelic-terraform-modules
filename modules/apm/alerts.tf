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