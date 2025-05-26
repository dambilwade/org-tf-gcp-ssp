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

