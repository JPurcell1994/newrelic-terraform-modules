variable "container_name" {
  type = string
}

variable "apm_application_name" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "dashboard_name" {
  type = string
}

variable "runbook_url" {
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
  default = "0.1"
  type    = string
}

variable "enable_error_alert" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = false
}