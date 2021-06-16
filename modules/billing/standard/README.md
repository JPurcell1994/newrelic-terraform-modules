## How to Use modules/billing/standard:


In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```
module "standard" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/billing/standard"
  ec2_limit_amount = "upper limit on ec2 spend per month in dollars"
  rds_limit_amount = "upper limit on rds spend per month in dollars"
  elasticsearch_limit_amount = "upper limit on elasticsearch spend per month in dollars"
  aws_total_limit_amount     = "upper limit on your entire amazon budget for the account"
  provider_account_id = "after adding the billing integration you will receive a newrelic provider account id, usually a 5 digit code in the URL when viewing any integration dashboards"
  runbook_url = "<link to the runbook url, feel free to use generic support page if no specific one exists for the app>"
  newrelic_channel_name = "<name of the notification channel you want the alert to send to as seen through new relic UI>"
  dashboard_name = "<the name you want your dashboard to have>"
}
```
The terraform will create 3 budgets through AWS, tracking RDS, EC2 and ElasticSearch cost. We then pass these variables alongside the others you provide into terraform

This will create a dashboard with all the metrics these budgets provides

- The actual cost month to date from EC2/RDS/ES, 
- The forecasted cost by end of month for EC2/RDS/ES, 
- The monthly allocated bill for EC2/RDS/ES, 

It will also create some alerts for you and post them to the notification channel provided

- If EC2 Forecasted Spend > EC2 limit amount,
- If RDS Forecasted Spend > RDS Limit amount,
- If ElasticSearch Forecasted Spend > ElasticSearch limit amount
