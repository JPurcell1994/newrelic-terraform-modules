resource "newrelic_dashboard" "cluster_dashboard" {
  title = var.dashboard_name

  widget {
    title         = "CPU Used"
    visualization = "billboard_comparison"
    nrql          = "SELECT (average(cpuUsedCores) * uniqueCount(entityName)) as 'Cores' FROM K8sNodeSample where clusterName = '${var.cluster_name}'"
    row           = 1
    column        = 1
  }

  widget {
    title         = "Memory Used"
    visualization = "billboard_comparison"
    nrql          = "SELECT (average(memoryUsedBytes) * uniqueCount(entityName)) / 1000000000 as 'Mem GB' FROM K8sNodeSample where clusterName = '${var.cluster_name}'"
    row           = 1
    column        = 2
  }

  widget {
    title         = "# of K8s Objects"
    visualization = "billboard"
    nrql          = "SELECT uniqueCount(K8sNodeSample.entityId) as 'Nodes', uniqueCount(K8sNamespaceSample.clusterName) as 'Clusters', uniqueCount(K8sNamespaceSample.entityId) as 'Namespaces', uniqueCount(K8sDeploymentSample.entityId) as 'Deployments', uniqueCount(K8sPodSample.entityId) as 'Pods', uniqueCount(K8sContainerSample.containerID) as 'Containers' FROM K8sNodeSample, K8sNamespaceSample, K8sDeploymentSample, K8sPodSample, K8sContainerSample Until 1 minute ago WHERE clusterName = '${var.cluster_name}'"
    row           = 1
    column        = 3
  }

  widget {
    title         = "Pods by Namespace"
    visualization = "facet_bar_chart"
    nrql          = "FROM K8sPodSample SELECT uniqueCount(entityId) as 'pod' FACET namespace WHERE clusterName = '${var.cluster_name}'"
    row           = 2
    column        = 1
  }

  widget {
    title         = "Containers by Namespace"
    visualization = "faceted_line_chart"
    nrql          = "SELECT uniqueCount(containerID) FROM K8sContainerSample facet namespace TIMESERIES WHERE clusterName = '${var.cluster_name}'"
    row           = 2
    column        = 2
  }

  widget {
    title         = "Pod Count by Node"
    visualization = "facet_bar_chart"
    nrql          = "SELECT uniquecount(podName) from K8sPodSample where status='Running' facet nodeName, label.NodeGroup WHERE clusterName = '${var.cluster_name}'"
    row           = 2
    column        = 3
  }

  widget {
    title         = "Container CPU Usage - % Used vs Limit"
    visualization = "faceted_line_chart"
    nrql          = "FROM K8sContainerSample SELECT latest(cpuUsedCores/cpuLimitCores) * 100 as '% CPU' FACET podName, containerName TIMESERIES auto WHERE clusterName = '${var.cluster_name}' Since 3 days ago"
    row           = 3
    column        = 1
  }

  widget {
    title         = "Container Memory Usage - % Used vs Limit"
    visualization = "faceted_line_chart"
    nrql          = "FROM K8sContainerSample SELECT latest(memoryUsedBytes/memoryLimitBytes) * 100 as '% Memory' FACET podName, containerName TIMESERIES auto WHERE clusterName = '${var.cluster_name}' Since 3 days ago"
    row           = 3
    column        = 2
  }

  widget {
    title         = "Volume Usage - % Used"
    visualization = "faceted_line_chart"
    nrql          = "FROM K8sVolumeSample select latest(fsUsedPercent) facet podName timeseries WHERE clusterName = '${var.cluster_name}' Since 3 days ago"
    row           = 3
    column        = 3
  }

  widget {
    title         = "Container CPU Cores Used"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(cpuUsedCores) as 'CPU Cores Used' from K8sContainerSample FACET clusterName, podName, containerName timeseries WHERE clusterName = '${var.cluster_name}'"
    row           = 4
    column        = 1
  }

  widget {
    title         = "Container MBytes of Memory Used"
    visualization = "faceted_line_chart"
    nrql          = "SELECT average(memoryUsedBytes / 1000000) as 'MB of Mem' from K8sContainerSample FACET clusterName, podName, containerName timeseries WHERE clusterName = '${var.cluster_name}'"
    row           = 4
    column        = 2
  }

  widget {
    title         = "Missing Pods by Deployment"
    visualization = "faceted_area_chart"
    nrql          = "SELECT latest(podsDesired) - latest(podsReady) as 'Missing Pods' FROM K8sReplicasetSample facet clusterName, deploymentName timeseries WHERE clusterName = '${var.cluster_name}'"
    row           = 4
    column        = 3
  }
}
