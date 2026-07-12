resource "azurerm_iot_security_device_group" "iot_security_device_groups" {
  for_each = var.iot_security_device_groups

  iothub_id = each.value.iothub_id
  name      = each.value.name

  dynamic "allow_rule" {
    for_each = each.value.allow_rule != null ? [each.value.allow_rule] : []
    content {
      connection_from_ips_not_allowed = allow_rule.value.connection_from_ips_not_allowed
      connection_to_ips_not_allowed   = allow_rule.value.connection_to_ips_not_allowed
      local_users_not_allowed         = allow_rule.value.local_users_not_allowed
      processes_not_allowed           = allow_rule.value.processes_not_allowed
    }
  }

  dynamic "range_rule" {
    for_each = each.value.range_rule != null ? each.value.range_rule : []
    content {
      duration = range_rule.value.duration
      max      = range_rule.value.max
      min      = range_rule.value.min
      type     = range_rule.value.type
    }
  }
}

