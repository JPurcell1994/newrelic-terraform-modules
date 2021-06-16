# BYOA (Build your own NRQL Alerts)

BYOA is here to allow you to terraform your own alert policies if you know the NRQL for them

An example

```hcl
module "byoa-alerts" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/BYOA"
  policy_name = "XXYYZZ"
  channel_ids = ["XXYYZZ"] 
  runbook_url = "https://XXYYZZ"


  alerts = [
    {
      condition_name     = ""
      operator           = "above"
      critical_threshold = 0.8
      duration           = 300
      occurrences        = "all"
      query              = ""
    },
    {
      condition_name     = ""
      operator           = "above"
      critical_threshold = 0.8
      duration           = 300
      occurrences        = "at_least_once"
      query              = ""
    }
  ]
}
```
The module will build ONE alert policy with name, policy_name, then attach as many alert conditions to this policy, as defined in the blocks.

You need to provide a, name for the condition, an operator (above, below, equal), a threshold, so if value operator critical threshhold, trigger an alert, duration only matters if you choose all for occurrences.

If you choose "all" for occurrences, this means EVERY data point within the duration needs to be above the threshhold to report, at_least_once will alert if any data point breaks the threshhold limits.

Query is the NRQL query required, I advise creating the alert once in NewRelic UI to see if it's correct, seen some weird naming standards and orders in NRQL alert conditions.