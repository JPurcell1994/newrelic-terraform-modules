data "newrelic_entity" "apm_application" {
  name = var.apm_application_name
  domain = "APM"
  type = "APPLICATION"
}
