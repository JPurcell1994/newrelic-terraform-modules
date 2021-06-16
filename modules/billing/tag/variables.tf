## Has to be of the form TAGKEY$TAGVALUE ClusterName$recs-eks-main-live eg
variable "tag_keyvalue" {
  type = string
}

variable "tag_keyvalue_amount"{
  type = string
}

variable "newrelic_channel_name" {
  type = string
}

variable "dashboard_name" {
  type = string
}

variable "provider_account_id" {
  type = string
}

variable "runbook_url" {
  type = string
}

variable "budget_name" {
  type = string
}