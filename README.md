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
