variable "apm_application_name" {
  type = string
}

variable "runbook_url" {
  type = string
}

variable "dashboard_name" {
  type = string
}

variable "newrelic_channel_name" {
  type = string
}

variable "enable_apdex_alert" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = false
}

variable "enable_responsetime_alert" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = false
}

variable "responsetime_threshhold" {
  default = "100"
  type    = string
}

variable "enable_error_alert" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = false
}
