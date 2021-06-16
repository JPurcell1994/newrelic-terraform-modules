resource "newrelic_dashboard" "kafka-producer" {
  title = var.dashboard_name

  dynamic "widget" {
    for_each = var.dashboard_widgets
    content {
      title         = widget.value.name_suffix
      visualization = widget.value.visualization
      nrql          = widget.value.nrql
      row    = widget.value.row
      column = widget.value.column
      width  = widget.value.width
    }
  }

}