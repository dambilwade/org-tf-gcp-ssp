//The list of variables defined in root module

variable "instance_map" {
    description = "List the instance"
    type = map(object({instance_name_value = string}))
}

variable "service_account" {
    description = "Service account to be used"
    type        = string
}

variable "project_id" {
    description = "Project ID to be used"
    type        = string
}

variable "region" {
    description = "region to be used"
    type        = string
}

variable "zone" {
    description = "zone to be used"
    type        = string
}

