resource "newrelic_alert_policy" "policy" {

  name        = var.policy_name
  channel_ids = var.channel_ids
}

resource "newrelic_nrql_alert_condition" "additional_alerts_condition" {
  count = length(var.alerts)

  policy_id  = newrelic_alert_policy.policy.id

  name        = var.alerts[count.index].condition_name
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = "true"

  critical {
    operator              = var.alerts[count.index].operator
    threshold             = var.alerts[count.index].critical_threshold
    threshold_duration    = var.alerts[count.index].duration
    threshold_occurrences = var.alerts[count.index].occurrences
  }

  nrql {
    query             = var.alerts[count.index].query
    evaluation_offset = 3
  }

  value_function               = "single_value"
  violation_time_limit_seconds = 3600
}
