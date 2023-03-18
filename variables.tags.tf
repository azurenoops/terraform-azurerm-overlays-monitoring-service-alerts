# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

variable "default_tags_enabled" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "add_tags" {
  description = "Extra tags to set on each created resource."
  type        = map(string)
  default     = {}
}