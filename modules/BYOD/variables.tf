variable "dashboard_name" {
  type = string
}

variable "dashboard_widgets" {
  description = "List of custom widget in case you need to create your own custom one"
  type = list(object({
    name_suffix   = string
    visualization = string
    row           = number
    column        = number
    width         = number
    nrql          = string
  }))
  default = []
}