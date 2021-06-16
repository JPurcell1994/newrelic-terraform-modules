## How to Use modules/elasticsearch :

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```
module "elasticsearch" {
  source                                = "../../modules/elasticsearch"
  provider_account_id                   = "<Account ID given to the account by NewRelic>"
  runbook_url                           = "<Runbook URL you want attached to the alert condition>"
  newrelic_channel_name                 = "<NewRelic Channel name you wish to publish alerts too>"
  alert_policy_name                     = "<The name you want the alert policy to have>"
  dashboard_name                        = "<Dashboard name you want the rds dashboard to have>"
  elasticsearch_write_latency_threshold = "<Amount in seconds, if elasticsearch write latency above this, alerts>"
  elasticsearch_read_latency_threshold  = "<Similar to above, for read latency>"
  elasticsearch_min_storage_available   = "<Alert when minimum storage of a cluster goes below this value, in MB (Aka 10000 = 10GB)>"
}
```

The terraform code will use the ElasticSearch Integration in NewRelic and create a dashboard with

- ElasticSearch Total Requests
- ElasticSearch 4XX and 5XX Response Codes
- ELasticSearch Average Read and Write Latency
- ElasticSearch Free Storage Space
- ElasticSearch Red Cluster Status
- ElasticSearch CPU Utilisation
- ElasticSearch JVM Memory Pressure

It will also create some alerts for you and post them to whatever Newrelic notification channel you specify in newrelic_channel_name

- If ElasticSearch Red Cluster > 0
- If ElasticSearch Min Storage < "elasticsearch_min_storage_available"
- If ElasticSearch Read Latency > "elasticsearch_read_latency_threshold"
- If ElasticSearch Write Latency > "elasticsearch_write_latency_threshold"
- If ElasticSearch CPU Utilisation > 90%
- If ElasticSearch 5XX Response > 0
- If ElasticSearch JVM Memory Pressure > 90%

