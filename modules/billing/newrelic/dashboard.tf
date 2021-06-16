resource "newrelic_dashboard" "billing_dashboard" {
  title = var.dashboard_name

  widget {
    title = "Total NewRelic Cost Last Month"
    visualization = "billboard"
    nrql = "SELECT filter(SUM(apmHoursUsed)/750 *  27.53,  WHERE `productLine` = 'APM' AND `usageType` = 'Host') + filter(SUM(browserPageViewCount) / 500000 * 27.53,  WHERE `productLine` = 'Browser' AND `usageType` = 'Application' and isPrimaryApp != 'false' ) + filter (rate(SUM(insightsTotalEventCount - insightsIncludedEventCount), 1 day) / 75000000 * 46.20, WHERE `productLine` = 'Insights' AND `usageType` = 'Event') + filter(SUM(syntheticsSuccessCheckCount + syntheticsFailedCheckCount) / 10000 * 91 * 0.14, WHERE `productLine` = 'Synthetics' AND `usageType` = 'Check' AND `syntheticsTypeLabel` != 'Ping') + filter(sum(mobileUniqueUsersPerMonth), WHERE `productLine` = 'Mobile' AND `usageType` = 'Application' and  dateOf(timestamp)  like 'Jun% 30%') / 100000 * 184.60  + filter(SUM(infrastructureComputeUnits), WHERE `productLine` = 'Infrastructure' AND `usageType` = 'Host') * 0.000222  as 'Monthly Cost $' from NrDailyUsage SINCE last month until this month"
    row = 1
    column = 1
    width = 1
  }

  widget {
    title = "Extrapolated NewRelic Yearly Cost"
    visualization = "billboard"
    nrql = "SELECT filter(SUM(apmHoursUsed)/750 *  27.53 * 12,  WHERE `productLine` = 'APM' AND `usageType` = 'Host') + filter(SUM(browserPageViewCount) / 500000 * 27.53 * 12,  WHERE `productLine` = 'Browser' AND `usageType` = 'Application' AND `usageType` = 'Application') + filter (rate(SUM(insightsTotalEventCount - insightsIncludedEventCount), 1 day) / 75000000 * 46.20 * 12, WHERE `productLine` = 'Insights' AND `usageType` = 'Event') + filter(SUM(syntheticsSuccessCheckCount + syntheticsFailedCheckCount) / 10000 * 91 * 0.14 * 12, WHERE `productLine` = 'Synthetics' AND `usageType` = 'Check' AND `syntheticsTypeLabel` != 'Ping') + filter(sum(mobileUniqueUsersPerMonth), WHERE `productLine` = 'Mobile' AND `usageType` = 'Application' and  dateOf(timestamp)  like 'Jun% 30%') / 100000 * 184.60  * 12  + filter(SUM(infrastructureComputeUnits), WHERE `productLine` = 'Infrastructure' AND `usageType` = 'Host') * 0.000222 * 12  as 'Extrapolated Yearly License Cost $' from NrDailyUsage SINCE last month until this month"
    row = 1
    column = 2
    width = 2
  }

  widget {
    title = "APM Costs - Last Month"
    visualization = "billboard"
    nrql = "SELECT SUM(apmHoursUsed)/750 * 27.53 as '$' FROM NrDailyUsage WHERE `productLine` = 'APM' AND `usageType` = 'Host' SINCE last month until this month limit 30"
    row = 2
    column = 1
    width = 1
  }

  widget {
    title = "APM Costs - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT SUM(apmHoursUsed)/750 * 27.53 as '$' FROM NrDailyUsage WHERE `productLine` = 'APM' AND `usageType` = 'Host' FACET monthOf(timestamp) SINCE 12 month ago limit 100"
    row = 2
    column = 2
    width = 2
  }

  widget {
    title = "Insights Costs + Total Events - Last Month"
    visualization = "billboard"
    nrql = "SELECT rate(sum(insightsTotalEventCount - insightsIncludedEventCount), 1 day) / 75000000 * 46.20 as '$', rate(sum(insightsTotalEventCount - insightsIncludedEventCount), 1 day) as 'Events' FROM NrDailyUsage WHERE  `productLine` = 'Insights' AND `usageType` = 'Event' SINCE last month until this month limit 1000"
    row = 3
    column = 1
    width = 1
  }

  widget {
    title = "Insights Costs + Events - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT sum(insightsTotalEventCount - insightsIncludedEventCount)/uniqueCount(timestamp) / 75000000 * 46.20 as '$', rate(sum(insightsTotalEventCount - insightsIncludedEventCount), 1 day) as 'Events' FROM NrDailyUsage WHERE `productLine` = 'Insights' AND `usageType` = 'Event' AND `insightsEventNamespace` != 'Tracing Spans'  FACET monthOf(timestamp) SINCE 12 months ago"
    row = 3
    column = 2
    width = 2
  }

  widget {
    title = "Infrastructure Costs - Last Month"
    visualization = "billboard"
    nrql = "SELECT SUM(infrastructureComputeUnits) * 0.000222 as '$' FROM NrDailyUsage WHERE `productLine` = 'Infrastructure' AND `usageType` = 'Host' SINCE last month until this month LIMIT 1000"
    row = 4
    column = 1
    width = 1
  }

  widget {
    title = "Infrastructure Costs - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT SUM(infrastructureComputeUnits) * 0.000222 as '$' FROM NrDailyUsage WHERE `productLine` = 'Infrastructure' AND `usageType` = 'Host' FACET monthOf(timestamp) SINCE 12 months ago LIMIT 1000"
    row = 4
    column = 2
    width = 2
  }

  widget {
    title = "Mobile Costs - Last Month"
    visualization = "billboard"
    nrql = "SELECT sum(mobileUniqueUsersPerMonth)/ 100000 * 184.60 as '$' FROM NrDailyUsage WHERE `productLine` = 'Mobile' AND `usageType` = 'Application' SINCE last month until this month where dateOf(timestamp) like 'Jun% 30%'"
    row = 5
    column = 1
    width = 1
  }

  widget {
    title = "Mobile Costs - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT sum(mobileUniqueUsersPerMonth) / 100000 * 184.60 as '$' FROM NrDailyUsage  where dateOf(timestamp)  like 'Jan% 31%' OR dateOf(timestamp)  like 'March% 31%' OR dateOf(timestamp)  like 'May% 31%' OR dateOf(timestamp)  like 'July% 31%' OR dateOf(timestamp)  like 'Oct% 31%'  OR dateOf(timestamp)  like 'Dec% 31%'  OR dateOf(timestamp)  like 'Apr% 30%'  OR dateOf(timestamp)  like 'June% 30%'  OR dateOf(timestamp)  like 'Aug% 30%'  OR dateOf(timestamp)  like 'Sep% 30%'  OR dateOf(timestamp)  like 'November% 30%'  OR dateOf(timestamp)  like 'Feb% 29%' SINCE 12 months ago UNTIL today FACET monthOf(timestamp) LIMIT 40"
    row = 5
    column = 2
    width = 2
  }

  widget {
    title = "Browser Costs - Last Month"
    visualization = "billboard"
    nrql = "SELECT SUM(browserPageViewCount) / 500000 * 27.53 as '$' FROM NrDailyUsage WHERE `productLine` = 'Browser' AND `usageType` = 'Application' and isPrimaryApp != 'false' SINCE last month until this month limit 150"
    row = 6
    column = 1
    width = 1
  }

  widget {
    title = "Browser Costs - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT SUM(browserPageViewCount) / 500000 * 27.53 as '$' FROM NrDailyUsage WHERE `productLine` = 'Browser' AND `usageType` = 'Application' and isPrimaryApp != 'false' FACET monthOf(timestamp) SINCE 12 months ago LIMIT 1000"
    row = 6
    column = 2
    width = 2
  }

  widget {
    title = "Synthetics Costs - Last Month"
    visualization = "billboard"
    nrql = "SELECT SUM(syntheticsSuccessCheckCount + syntheticsFailedCheckCount) / 10000 * 12.75 as '$' FROM NrDailyUsage WHERE `productLine` = 'Synthetics' AND `usageType` = 'Check' AND `syntheticsTypeLabel` != 'Ping'  SINCE last month until this month limit 30"
    row = 7
    column = 1
    width = 1
  }

  widget {
    title = "Synthetics Costs - Last 12 Months"
    visualization = "facet_table"
    nrql = "SELECT SUM(syntheticsSuccessCheckCount + syntheticsFailedCheckCount) / 10000 * 12.75  as ‘$’ FROM NrDailyUsage WHERE productLine = ‘Synthetics’ AND usageType = ‘Check’ AND syntheticsTypeLabel != ‘Ping’ FACET monthOf(timestamp) SINCE 12 months ago LIMIT 1000"
    row = 7
    column = 2
    width = 2
  }

  widget {
    title = "CloudHealth Calls Last 30 Days"
    visualization = "billboard"
    nrql = "SELECT sum(requestCount) as 'API calls' FROM IntegrationProviderReport FACET providerAccountName, awsServiceName where awsServiceName = 'AmazonCloudWatch' SINCE 30 days ago"
    row = 8
    column = 1
    width = 3
  }


}