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
        v.range_rule == null || (v.range_rule.max >= 0)
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.iot_security_device_groups : (
        v.range_rule == null || (v.range_rule.min >= 0)
      )
    ])
    error_message = "must be at least 0"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_iot_security_device_group's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: iothub_id
  #   source:    [from iothubValidate.IotHubID] !ok
  # path: iothub_id
  #   source:    [from iothubValidate.IotHubID] err != nil
  # path: allow_rule.connection_from_ips_not_allowed[*]
  #   source:    [from validate.CIDR] re != nil && !re.MatchString(cidr)
  # path: allow_rule.connection_to_ips_not_allowed[*]
  #   source:    [from validate.CIDR] re != nil && !re.MatchString(cidr)
  # path: range_rule.type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: range_rule.duration
  #   source:    [from validate.ISO8601Duration] !ok
  # path: range_rule.duration
  #   source:    [from validate.ISO8601Duration] err != nil
}

