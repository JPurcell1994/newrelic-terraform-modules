## How to Use modules/billing/tag:

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```
module "tagkeyvalue" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/billing/standard"
  budget_name = "The name of the AWS budget you want to have"
  tag_keyvalue = "Has to be of the form TAGKEY$TAGVALUE, ClusterName$recs-eks-main-live eg"
  tag_keyvalue_amount = "upper limit on the above tag_keyvalue budget"
  provider_account_id = "after adding the billing integration you will receive a newrelic provider account id, usually a 5 digit code in the URL when viewing any integration dashboards"
  runbook_url = "<link to the runbook url, feel free to use generic support page if no specific one exists for the app>"
  newrelic_channel_name = "<name of the notification channel you want the alert to send to as seen through new relic UI>"
  dashboard_name = "<the name you want your dashboard to have>"
}
```
## The allowed tagKeys are as follows

- ClusterName
- Contact
- Environment
- Name
- Role
- SubProduct

The terraform will create a budget filtering out only those with the tag_keyvalue tagged to them. For example, if you want to make a budget covering everything with the Tag, SubProduct = Product1, call in the module

```
module "tag_SubProduct" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/billing/tag"
  tag_keyvalue = "SubProduct$Product1"
  ....
}
```

If you wanted to filter out everything with an attached ClusterName of Cluster1
```
module "tag_ClusterName" {
  source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/billing/tag"
  tag_keyvalue = "ClusterName$Cluster1"
  ....
}
```

This will create a dashboard with the metrics this budgets provides

- The actual cost month to date from this tag key value, 
- The forecasted cost by end of month from this tag key value, 
- The monthly allocated bill from this tag key value, 

It will also create an alert for you and post them to the notification channel provided

- If Budget Forecasted Spend > Budget limit amount