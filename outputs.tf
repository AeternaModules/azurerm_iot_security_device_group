output "iot_security_device_groups_allow_rule" {
  description = "Map of allow_rule values across all iot_security_device_groups, keyed the same as var.iot_security_device_groups"
  value       = { for k, v in azurerm_iot_security_device_group.iot_security_device_groups : k => v.allow_rule }
}
output "iot_security_device_groups_iothub_id" {
  description = "Map of iothub_id values across all iot_security_device_groups, keyed the same as var.iot_security_device_groups"
  value       = { for k, v in azurerm_iot_security_device_group.iot_security_device_groups : k => v.iothub_id }
}
output "iot_security_device_groups_name" {
  description = "Map of name values across all iot_security_device_groups, keyed the same as var.iot_security_device_groups"
  value       = { for k, v in azurerm_iot_security_device_group.iot_security_device_groups : k => v.name }
}
output "iot_security_device_groups_range_rule" {
  description = "Map of range_rule values across all iot_security_device_groups, keyed the same as var.iot_security_device_groups"
  value       = { for k, v in azurerm_iot_security_device_group.iot_security_device_groups : k => v.range_rule }
}

