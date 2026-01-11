variable "iot_security_device_groups" {
  description = <<EOT
Map of iot_security_device_groups, attributes below
Required:
    - iothub_id
    - name
Optional:
    - allow_rule (block):
        - connection_from_ips_not_allowed (optional)
        - connection_to_ips_not_allowed (optional)
        - local_users_not_allowed (optional)
        - processes_not_allowed (optional)
    - range_rule (block):
        - duration (required)
        - max (required)
        - min (required)
        - type (required)
EOT

  type = map(object({
    iothub_id = string
    name      = string
    allow_rule = optional(object({
      connection_from_ips_not_allowed = optional(set(string))
      connection_to_ips_not_allowed   = optional(set(string))
      local_users_not_allowed         = optional(set(string))
      processes_not_allowed           = optional(set(string))
    }))
    range_rule = optional(object({
      duration = string
      max      = number
      min      = number
      type     = string
    }))
  }))
}

