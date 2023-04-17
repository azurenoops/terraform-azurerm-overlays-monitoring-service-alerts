# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
###########################
# Global Configuration   ##
###########################

variable "environment" {
  description = "The Terraform backend environment e.g. public or usgovernment"
  type        = string
  default     = "public"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
}

variable "org_name" {
  description = "A name for the organization. It defaults to anoa."
  type        = string
  default     = "anoa"
}

variable "workload_name" {
  description = "A name for the workload. It defaults to hub-core."
  type        = string
  default     = "testlinux"
}

variable "deploy_environment" {
  description = "The environment to deploy. It defaults to dev."
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map(string)
}

#######################
# RG Configuration   ##
#######################

variable "create_alerts_resource_group" {
  description = "Controls if the resource group should be created. If set to false, the resource group name must be provided. Default is false."
  type        = bool
  default     = false
}

variable "existing_resource_group_name" {
  description = "The name of the existing resource group to use for action group. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}

variable "use_location_short_name" {
  description = "Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored."
  type        = bool
  default     = true
}

###########################
# Alerts Configuration   ##
###########################

variable "monitoring_resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "action_group_webhooks" {
  description = "Map of Webhooks to notify. Example: `{ PagerDuty = 'https://events.pagerduty.com/integration/abcdefgh12345azerty/enqueue' }`."
  type        = map(string)
  default     = {}
}

variable "action_group_emails" {
  description = "Map of Emails to notify. Example: `{ ml-devops = devops@contoso.com }`."
  type        = map(string)
  default     = {}
}

variable "activity_log_alerts" {
  description = "Map of Activity log Alerts."
  type = map(object({
    description         = optional(string)
    custom_name         = optional(string)
    resource_group_name = optional(string)
    scopes              = list(string)
    criteria = object({
      operation_name = optional(string)
      category       = optional(string, "Recommendation")
      level          = optional(string, "Error")
      status         = optional(string)

      resource_provider = optional(string)
      resource_type     = optional(string)
      resource_group    = optional(string)
      resource_id       = optional(string)
    })
  }))
  default = {}
}

variable "service_health" {
  description = "A block supports the following: `events`, `locations` and `services`. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert"
  type = object({
    events    = optional(string, "Incident")
    locations = optional(string, "Global")
    services  = optional(string)
  })
  default = null
}

variable "metric_alerts" {
  description = "Map of metric Alerts"
  type = map(object({
    custom_name              = optional(string, null)
    description              = optional(string, null)
    resource_group_name      = optional(string)
    scopes                   = optional(list(string), [])
    enabled                  = optional(bool, true)
    auto_mitigate            = optional(bool, true)
    severity                 = optional(number, 3)
    frequency                = optional(string, "PT5M")
    window_size              = optional(string, "PT5M")
    target_resource_type     = optional(string, null)
    target_resource_location = optional(string, null)

    tags = optional(map(string), {})

    criteria = optional(list(object({
      metric_namespace       = string
      metric_name            = string
      aggregation            = string
      operator               = string
      threshold              = number
      skip_metric_validation = optional(bool, false)
      dimension = optional(list(object({
        name     = string
        operator = optional(string, "Include")
        values   = list(string)
      })), [])
    })), [])

    dynamic_criteria = optional(list(object({
      metric_namespace         = string
      metric_name              = string
      aggregation              = string
      operator                 = string
      alert_sensitivity        = optional(string, "Medium")
      evaluation_total_count   = optional(number, 4)
      evaluation_failure_count = optional(number, 4)
      ignore_data_before       = optional(string)
      skip_metric_validation   = optional(bool, false)
      dimension = optional(list(object({
        name     = string
        operator = optional(string, "Include")
        values   = list(string)
      })), [])
    })), [])

    application_insights_web_test_location_availability_criteria = optional(object({
      web_test_id           = string
      component_id          = string
      failed_location_count = number
    }), null)
  }))

  default = {}
}