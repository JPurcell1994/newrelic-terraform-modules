## How to Use modules/billing/newrelic:


In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```
module "newrelic" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/billing/newrelic"
  dashboard_name = "<The name you want the dashboard to have>"
}
```

This will build a set of dashboards for you in NewRelic, with costs from last month and the last 12 months for

- Total cost spent by NewRelic
- APM
- Insights
- Infrastructure
- Mobile
- Browser
