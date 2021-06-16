resource "aws_budgets_budget" "Tag" {

  name              = var.budget_name
  budget_type       = "COST"
  limit_amount      = var.tag_keyvalue_amount
  limit_unit        = "USD"
  time_period_end   = "2087-05-11_00:00"
  time_period_start = "2020-05-11_00:00"
  time_unit         = "MONTHLY"

##   cost_filters = { TagKeyValue = "user:ClusterName$recs-eks-main-live"}

  cost_filters = {
    TagKeyValue = "user:${var.tag_keyvalue}"
  }

}
