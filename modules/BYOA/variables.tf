variable "alerts" {
  description = "List of a custom alerts in case you need to create your own one"
  type = list(object({
    condition_name     = string
    operator           = string
    critical_threshold = number
    duration           = number
    query              = string
    occurrences        = string
  }))
  default = []
}

variable "policy_name" {
  type = string
}

variable "channel_ids" {
  type = list(string)
}

variable "runbook_url" {
  type = string
}