# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  action_group_name = coalesce(var.custom_action_group_name, data.azurenoopsutils_resource_name.action_group.result)
}