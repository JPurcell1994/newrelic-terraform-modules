resource "newrelic_dashboard" "application_dashboard" {
  title = var.dashboard_name

  widget {
    title         = "${var.apm_application_name}-ResponseTime"
    visualization = "application_breakdown"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    row           = 1
    column        = 1
    width         = 2
  }

  widget {
    title         = "${var.apm_application_name}-Throughput"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "HttpDispatcher"
      values = ["requests_per_minute"]
    }
    row    = 1
    column = 3
    width  = 1
  }


  widget {
    title         = "${var.apm_application_name}-Apdex"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "Apdex"
      values = ["score"]
    }
    limit  = 5
    row    = 2
    column = 1
    width  = 2
  }

  widget {
    title         = "${var.apm_application_name}-Errors"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "Errors/all"
      values = ["error_rate"]
    }
    row    = 1
    column = 3
    width  = 1
  }

}