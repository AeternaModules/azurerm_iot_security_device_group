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
    range_rule = optional(list(object({
      duration = string
      max      = number
      min      = number
      type     = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.iot_security_device_groups : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.iot_security_device_groups : (
        v.range_rule == null || alltrue([for item in v.range_rule : (item.max >= 0)])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.iot_security_device_groups : (
        v.range_rule == null || alltrue([for item in v.range_rule : (item.min >= 0)])
      )
    ])
    error_message = "must be at least 0"
  }
  # Note: 7 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

