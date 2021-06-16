resource "newrelic_dashboard" "elasticsearch_dashboard" {
  title = var.dashboard_name

  widget {
    title         = "ElasticSearch Total Requests"
    visualization = "faceted_line_chart"
    nrql          = "SELECT sum(`provider.ElasticsearchRequests.Sum`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES auto SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 1
    column        = 1
    width         = 1
  }

  widget {
    title         = "ElasticSearch 4XX Response Codes"
    visualization = "faceted_line_chart"
    nrql          = "SELECT sum(`provider.4xx.Sum`) as `4xx` FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES auto SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 1
    column        = 2
    width         = 1
  }

  widget {
    title         = "ElasticSearch 5XX Response Codes"
    visualization = "faceted_line_chart"
    nrql          = "SELECT sum(`provider.5xx.Sum`) as `5xx` FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES auto SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 1
    column        = 3
    width         = 1
  }

  widget {
    title         = "ElasticSearch Average Write Latency"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.WriteLatency.Average`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 2
    column        = 1
    width         = 1
  }

  widget {
    title         = "ElasticSearch Average Read Latency"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.ReadLatency.Average`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 2
    column        = 2
    width         = 1
  }

  widget {
    title         = "ElasticSearch Free Storage Space"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.FreeStorageSpace.Minimum`) / 1024 FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 hour  SINCE 1 day ago UNTIL 5 minutes ago FACET entityName"
    row           = 2
    column        = 3
    width         = 1
  }


  widget {
    title         = "ElasticSearch Red Cluster Status"
    visualization = "faceted_line_chart"
    nrql          = "SELECT min(`provider.ClusterStatus.red.Minimum`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 3
    column        = 1
    width         = 1
  }

  widget {
    title         = "ElasticSearch Average CPU Utilisation"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.CPUUtilization.Average`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 3
    column        = 2
    width         = 2
  }

  widget {
    title         = "ElasticSearch Nodes"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.Nodes.Average`) FROM DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes Since 1 hour ago Until 5 minutes ago FACET entityName"
    row           = 4
    column        = 1
    width         = 1
  }

  widget {
    title         = "ElasticSearch JVM Memory Pressure"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.JVMMemoryPressure.Maximum`) FROM  DatastoreSample WHERE provider='ElasticsearchCluster' AND providerAccountId = '${var.provider_account_id}' TIMESERIES 1 minutes SINCE 1 hour ago UNTIL 5 minutes ago FACET entityName"
    row           = 4
    column        = 2
    width         = 2
  }
}
