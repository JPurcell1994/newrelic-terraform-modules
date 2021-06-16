## How to Use modules/apm:

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```aidl
module "<module_name_as_recognised_in_terraform>" {
    source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/apm" 
    apm_application_name = "<the name of the application in APM>"
    dashboard_name = "<the name you want your dashboard to have>"
    runbook_url = "<link to the runbook url, feel free to use generic support page if no specific one exists for the app>"
    newrelic_channel_name = "<name of the notification channel you want the alert to send to as seen through new relic UI>"
    enable_apdex_alert = "<boolean, true or false, defaults to false if not specified>"
    enable_responsetime_alert = "<boolean, true or false, defaults to false if not specified>"
    responsetime_threshhold = "<Integer value for seconds when NewRelic should alert if response time goes over, defaults to 0.1s if not specified>"
    enable_error_alert = "<boolean, true or false, defaults to false if not specified>"
}
```

The terraform will create a dashboard and export its ID, and find the APM name and export its ID. We then pass these variables alongside the others you provide into terraform

This will create a dashboard with all the metrics APM provides

- The response time of the application, 
- The error rate of the application, 
- The throughput of the application, 
- The apdex of the application

It will also create some alerts for you and post them to the notification channel provided

- If Applications Apdex < 0.9
- If Applications ResponseTime > response_time_threshold, or 0.1s (100ms) if var not specified
- If Applications Error Rate > 0%

