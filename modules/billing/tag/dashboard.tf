resource "newrelic_dashboard" "billing_dashboard" {
  title = var.dashboard_name

  widget {
    title = "Cost ${var.budget_name}"
    visualization = "facet_table"
    nrql = "SELECT latest(`provider.budgetType`) as 'Budget Type', max(`provider.actualAmount`) as 'Actual Amount',max(`provider.limitAmount`) as 'Budget Limit', latest(`provider.forecastedAmount`) as 'Forecast' from FinanceSample where provider='BillingBudget' AND `provider.budgetName` LIKE '${aws_budgets_budget.Tag.name}' AND providerAccountId = '${var.provider_account_id}' facet `provider.budgetName` Since 1 day ago"
    row = 1
    column = 1
    width = 3
  }

  widget {
    title         = "Actual Cost Per Budget"
    visualization = "faceted_line_chart"
    nrql          = "SELECT max(`provider.actualAmount`) from FinanceSample where provider='BillingBudget' and `provider.budgetType`='COST' AND `provider.budgetName` LIKE '${aws_budgets_budget.Tag.name}' AND providerAccountId = '${var.provider_account_id}' TIMESERIES auto since 4 days ago facet `provider.budgetName`"
    row           = 2
    column        = 1
    width         = 1
  }

  widget {
    title         = "Forecasted Cost Per Budget"
    visualization = "faceted_line_chart"
    nrql          = "SELECT max(`provider.forecastedAmount`) from FinanceSample where provider='BillingBudget' and `provider.budgetType`='COST' AND `provider.budgetName` LIKE '${aws_budgets_budget.Tag.name}' AND providerAccountId = '${var.provider_account_id}' TIMESERIES auto since 4 days ago facet `provider.budgetName`"
    row           = 2
    column        = 2
    width         = 1
  }

  widget {
    title         = "Budget Remaining"
    visualization = "facet_table"
    nrql          = "SELECT  (max(`provider.limitAmount`) - max(`provider.actualAmount`)) as 'Budget Remaining', max(`provider.limitAmount`) as 'Budget Limit' from FinanceSample where provider='BillingBudget' AND `provider.budgetName` LIKE '${aws_budgets_budget.Tag.name}' AND providerAccountId = '${var.provider_account_id}' facet `provider.budgetName` Since 1 day ago"
    row           = 2
    column        = 3
    width         = 1
  }
}