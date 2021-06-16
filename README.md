# NewRelic Terraform Modules

Having worked quite extensively with NewRelic I built up these modules to help standardise the Dashboarding and Alerting across our real estate. Feel free to make local copies/clones and adapt to suit your companies needs.

More NewRelic documentation can be found [here](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs)

PreRequisites:
- Terraform
- An Amazon Account attached to NewRelic Account
- Full/Admin access on this NewRelic Account
- You will need to export the following when running
```
export NEW_RELIC_API_KEY="<your New Relic API key>"
export NEW_RELIC_REGION="<Your Region Here>"
```

## What is covered:

#### Dashboards and Alerts:

- [APM](./modules/apm)
- [Billing Standard](./modules/billing/standard)
- [Billing Tag](./modules/billing/tag) 
- [eks-apm-apps - APM applications living inside of EKS](./modules/eks-apm-apps)
- [ElasticSearch](./modules/elasticsearch)
- [RDS](./modules/rds)

#### Dashboards Alone:

- [BYOD - Build Your Own Dashboard](./modules/BYOD)
- [Billing NewRelic](./modules/billing/newrelic)
- [EKS Cluster](./modules/eks-cluster) // This is Dashboards alone to avoid the duplication of alerts from the Kubernetes integration itself

#### Alerts Alone:

- [BYOA - Build Your Own Alerts](./modules/BYOA)

### More Information:

Inside of each module there is a README which should give more verbose information as to what the module is going to create. 


### Future Plans:

Span across more services and if available, multiple cloud provider setups. 