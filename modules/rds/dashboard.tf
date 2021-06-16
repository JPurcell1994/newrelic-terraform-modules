resource "newrelic_dashboard" "rds_dashboard" {
  title = var.dashboard_name

  widget {
    title         = "RDS Read Operations Per Second"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.readIops.Average`) as 'Read Operations' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' Since 6 hours ago TIMESERIES Until 10 minutes ago facet displayName"
    row           = 1
    column        = 1
    width         = 1
  }

  widget {
    title         = "RDS Write Operations Per Second"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.writeIops.Average`) as 'Write Operations' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' Since 6 hours ago TIMESERIES Until 10 minutes ago facet displayName"
    row           = 1
    column        = 2
    width         = 1
  }

  widget {
    title         = "RDS Active Connections"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.databaseConnections.Average`) as 'connections in use' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' FACET displayName TIMESERIES Since 1 hour ago Until 10 minutes ago"
    row           = 1
    column        = 3
    width         = 1
  }

  widget {
    title         = "RDS CPU Utilisation"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.cpuUtilization.Average`) as 'CPU Utilization' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' TIMESERIES Until 10 minutes ago facet displayName Since 1 hour ago"
    row           = 2
    column        = 1
    width         = 1
  }

  widget {
    title         = "RDS Read Latency (Seconds)"
    visualization = "faceted_line_chart"
    nrql          = "SELECT sum(`provider.readLatency.Sum`) / 60 as 'seconds' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' timeseries 5 minutes Until 10 minutes ago Since 6 hours ago facet displayName"
    row           = 2
    column        = 2
    width         = 1
  }

  widget {
    title         = "RDS Write Latency (Seconds)"
    visualization = "faceted_line_chart"
    nrql          = "SELECT sum(`provider.writeLatency.Sum`) / 60 as 'seconds' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' timeseries 5 minutes Until 10 minutes ago Since 6 hours ago facet displayName"
    row           = 2
    column        = 3
    width         = 1
  }


  widget {
    title         = "RDS Network Received Throughput (Bytes)"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.networkReceiveThroughput.Average`) as 'Network Receive Throughput' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' TIMESERIES Since 1 hour ago Until 10 minutes ago facet displayName"
    row           = 3
    column        = 1
    width         = 1
  }

  widget {
    title         = "RDS Network Transmit Throughput (Bytes)"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.networkTransmitThroughput.Average`) as 'Network Transmit Throughput' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' TIMESERIES Since 1 hour ago Until 10 minutes ago facet displayName"
    row           = 3
    column        = 2
    width         = 1
  }

  widget {
    title         = "RDS Swap Usage (Megabytes)"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(`provider.swapUsageBytes.Average`) / 1048576 as 'Swap Usage' From DatastoreSample WHERE provider = 'RdsDbInstance' AND providerAccountId = '${var.provider_account_id}' TIMESERIES Since 355 minutes ago Until 10 minutes ago FACET displayName"
    row           = 3
    column        = 3
    width         = 1
  }
}
