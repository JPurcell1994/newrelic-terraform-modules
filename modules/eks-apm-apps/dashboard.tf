resource "newrelic_dashboard" "application_dashboard" {
  title = var.dashboard_name


  widget {
    title         = "${var.container_name}-cpuUsed/Limit"
    visualization = "faceted_line_chart"
    nrql          = "FROM K8sContainerSample SELECT latest(cpuUsedCores / cpuLimitCores) * 100 as '% CPU' FACET podName WHERE containerName like '${var.container_name}' and clusterName like '${var.eks_cluster_name}' UNTIL 1 minute ago TIMESERIES limit 50"
    row           = 1
    column        = 1
    width         = 2
  }

  widget {
    title         = "${var.container_name}-memUsed/Limit"
    visualization = "faceted_line_chart"
    nrql          = "FROM K8sContainerSample SELECT latest(memoryUsedBytes / memoryLimitBytes) * 100 as '% MEM' FACET podName WHERE containerName like '${var.container_name}' and clusterName like '${var.eks_cluster_name}' UNTIL 1 minute ago TIMESERIES limit 50"
    row           = 2
    column        = 1
    width         = 2
  }

  widget {
    title         = "${var.container_name}-responsetime"
    visualization = "application_breakdown"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    row           = 3
    column        = 1
    width         = 2
  }

  widget {
    title         = "${var.container_name}-throughput"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "HttpDispatcher"
      values = ["requests_per_minute"]
    }
    row    = 2
    column = 3
  }

  widget {
    title         = "${var.container_name}-errorrate"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "Errors/all"
      values = ["error_rate"]
    }
    row    = 1
    column = 3
  }

  widget {
    title         = "Apdex"
    duration      = 1800000
    visualization = "metric_line_chart"
    entity_ids    = [data.newrelic_entity.apm_application.application_id]
    metric {
      name   = "Apdex"
      values = ["score"]
    }
    limit  = 5
    row    = 3
    column = 3
  }

  widget {
    title         = "${var.container_name}-availability"
    visualization = "billboard"
    nrql          = "SELECT percentage(count(*), WHERE error is false) AS 'availability' FROM Transaction WHERE appName = '${var.apm_application_name}'  SINCE 7 days ago "
    row           = 4
    column        = 1
    width         = 2
  }
}

