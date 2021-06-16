# BYOD (Build your own Dashboard)

BYOD is here to allow you to terraform your own dashboards if you know the NRQL for them

An example

```hcl
module "byod-dashboard" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/BYOD"
  dashboard_name = "XXXYYZZ"


  dashboard_widgets = [
    {
      name_suffix   = "line_chart_name"
      visualization = "faceted_line_chart"
      row           = 1
      column        = 1
      width         = 1
      nrql          = ""
    },
    {
      name_suffix   = "billboard_name"
      visualization = "billboard"
      row           = 1
      column        = 2
      width         = 2
      nrql          = ""
    },
  ]
}
```

Providing a dashboard name, and the dashboard widget name, visualization, row column width and NRQL statement, it will dynamically add those widgets to a dashboard.

For more information on which visualisations are allowed, please click [here](https://github.com/hashicorp/terraform-provider-newrelic/blob/master/newrelic/resource_newrelic_dashboard.go#L59-L83)