## How to Use modules/eks-cluster:

In your terraform control repo / terraform files call in a module like below, all variables needed unless specified

```aidl
module "<module_name_as_recognised_in_terraform>" {
    source = "git@github.com:JPurcell1994/newrelic-terraform-modules.git//modules/eks-cluster" 
    eks_cluster_name = "<Your EKS cluster name as recognised in NewRelic>"
    dashboard_name = "<The name you want your dashboard to have>"
}
```

If you have the eks-cluster integration setup in your account, this will give you a dashboard with the following

- CPU Used
- Memory Used
- Total number of k8s objects in cluster
- Pods by namespace
- Containers by namespace
- Pod count by node
- Container CPU Usage (% Used vs Limit)
- Container Memory Usage (% Used vs Limit)
- Volume Usage (% Used)
- Individual Container CPU Used (Cores)
- Individual Container Memory Used (MBytes)
- Missing pods by deployment