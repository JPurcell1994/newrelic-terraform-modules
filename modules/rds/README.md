## How to Use modules/rds :

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```
module "rds" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/rds"
  provider_account_id = "<Account ID given to the account by NewRelic>"
  runbook_url = "<Runbook URL you want attached to the alert condition>"
  newrelic_channel_name      = "<NewRelic Channel name you wish to publish alerts too>"
  dashboard_name             = "<Dashboard name you want the rds dashboard to have>"
  rds_write_latency_threshold = "<Time in seconds you want to alert write latency over>"
  rds_read_latency_threshold = "<Time in seconds you want to alert read latency over>"
}
```

The terraform code will use the RDS Integration in NewRelic and create a dashboard with

- Read and Write Operations Per Second
- RDS Active Connections
- RDS CPU Utilisation
- RDS Read and Write Latency (Seconds)
- RDS Network Received and Network Transmit Throughput (Bytes)
- RDS Swap Usage (Megabytes)

It will also create some alerts for you and post them to whatever Newrelic notification channel you specify in newrelic_channel_name

- If CPU Utilisation > 90%
- If Read latency > "rds_read_latency_threshold"
- If Write Latency > "rds_write_latency_threshold"

