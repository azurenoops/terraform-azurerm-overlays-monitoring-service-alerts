# Azure Service Alerting Overlay Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurenoops/overlays-service-alerts/azurerm/)

This Overlay terraform module can create [Azure Service Alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-service-health) and [Azure Monitor Alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview)
with an [Action Group](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups) for notifications destination to be used in a [SCCA compliant Network](https://registry.terraform.io/modules/azurenoops/overlays-hubspoke/azurerm/latest).

## SCCA Compliance

This module can be SCCA compliant and can be used in a SCCA compliant Network. Enable SCCA compliant network rules to make it SCCA compliant.

For more information, please read the [SCCA documentation]("https://www.cisa.gov/secure-cloud-computing-architecture").

## Contributing

If you want to contribute to this repository, feel free to to contribute to our Terraform module.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Resources Used

- [Activity Log alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-activity-log)
- [Service Alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-service-health)

## Usage

```hcl

module "mod_service_alerts" {
  source = "azurenoops/overlays-service-alerts/azurerm"
  version = "0.1.0"

  # Resource Group
  existing_resource_group_name = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  org_name                     = var.org_name
  environment                  = var.environment
  deploy_environment           = var.deploy_environment
  workload_name                = var.workload_name

  action_group_short_name = "Alerting"

  action_group_webhooks = {
    PagerDuty = "https://events.pagerduty.com/integration/{integration-UID}/enqueue"
    Slack     = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
  }

  # Service Alerts
  service_alerts = [
    {
      name = "Service Alert 1"
      description = "Service Alert 1 Description"
      severity = "Sev1"
      enabled = true
      scopes = [
        "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-00000000-0000-0000-0000-000000000000/providers/Microsoft.Compute/virtualMachines/vm-00000000-0000-0000-0000-000000000000"
      ]
      conditions = [
        {
          field = "Status"
          operator = "Equals"
          values = ["Unavailable"]
        }
      ]
      actions = [
        {
          action_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-00000000-0000-0000-0000-000000000000/providers/microsoft.insights/actionGroups/ag-00000000-0000-0000-0000-000000000000"
        }
      ]
    }
  ]

  # Activity Log Alerts
  activity_log_alerts = [
    {
      name = "Activity Log Alert 1"
      description = "Activity Log Alert 1 Description"
      enabled = true
      scopes = [
        "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-00000000-0000-0000-0000-000000000000/providers/Microsoft.Compute/virtualMachines/vm-00000000-0000-0000-0000-000000000000"
      ]
      conditions = [
        {
          field = "category"
          operator = "Equals"
          values = ["Administrative"]
        }
      ]
      actions = [
        {
          action_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-00000000-0000-0000-0000-000000000000/providers/microsoft.insights/actionGroups/ag-00000000-0000-0000-0000-000000000000"
        }
        ]
    }
    ]
}
    
```
