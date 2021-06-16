## How to Use modules/eks-apm-apps:

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```aidl
module "<module_name_as_recognised_in_terraform>" {
    source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/eks-apm-apps"
    container_name = "<Container name as in EKS without the unique part at the end, do a kubectl get pods -n namespace to see the exact name>"
    apm_application_name = "<The corresponding name of the application in APM>"
    eks_cluster_name = "<Your EKS cluster name as recognised in NewRelic>"
    dashboard_name = "<The name you want your dashboard to have>"
    runbook_url = "<link to the runbook url, feel free to use generic support page if no specific one exists for the app>"
    newrelic_channel_name = "<name of the notification channel you want the alert to send to as seen through new relic UI>"
    enable_apdex_alert = "<boolean, true or false, defaults to false if not specified>"
    enable_responsetime_alert = "<boolean, true or false, defaults to false if not specified>"
    responsetime_threshhold = "<Integer value for seconds when NewRelic should alert if response time goes over, defaults to 0.1s if not specified>"
    enable_error_alert = "<boolean, true or false, defaults to false if not specified>"
}
```

If you have an application with APM enabled inside of an EKS cluster (With the correct EKS integration setup in NewRelic)

The terraform code will find your APM name and export its ID, it will create a brand-new dashboard, then attach to it, for all containers "like" <container_name>,
- the CPU Used / Limit through NRQL query,
- the Mem Used / Limit through NRQL query,
- the throughput from APM,
- the apdex from APM,
- the response time from APM

It will also create some alerts for you and post them to whatever Newrelic notification channel you specify in newrelic_channel_name

- If Individual Container CPU Used/Limit > 90%
- If Individual Container Mem Used/Limit > 90%
- If Applications Apdex < 0.9
- If Applications ResponseTime > response_time_threshold, or 0.1s (100ms) if var not specified
- If Applications Error Rate > 0%
