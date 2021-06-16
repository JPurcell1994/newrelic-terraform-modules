provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "newrelic_alert_policy" "budget_alerts" {
  name = "billing-${var.tag_keyvalue}-alert-policy-ntm"
}

resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  policy_id   = newrelic_alert_policy.budget_alerts.id
  channel_ids = [data.newrelic_alert_channel.alert_channel.id]
}

data "newrelic_alert_channel" "alert_channel" {
  name = var.newrelic_channel_name
}

resource "newrelic_nrql_alert_condition" "Tag_alert" {
  policy_id = newrelic_alert_policy.budget_alerts.id

  name        = "Tag Billing Alert Condition"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  critical {
    threshold_duration    = 300
    operator              = "above"
    threshold             = "1"
    threshold_occurrences = "all"
  }

  nrql {
    query             = "SELECT (latest(`provider.forecastedAmount`)/(max(`provider.limitAmount`))) from FinanceSample where provider='BillingBudget' AND provider.budgetName ='${aws_budgets_budget.Tag.name}' AND providerAccountId = '${var.provider_account_id}'"
    evaluation_offset = "3"
  }

  value_function = "single_value"
  violation_time_limit_seconds = 3600
}