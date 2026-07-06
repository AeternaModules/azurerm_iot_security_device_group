output "iot_security_device_groups" {
  description = "All iot_security_device_group resources"
  value       = azurerm_iot_security_device_group.iot_security_device_groups
}
output "iot_security_device_groups_allow_rule" {
  description = "List of allow_rule values across all iot_security_device_groups"
  value       = [for k, v in azurerm_iot_security_device_group.iot_security_device_groups : v.allow_rule]
}
output "iot_security_device_groups_iothub_id" {
  description = "List of iothub_id values across all iot_security_device_groups"
  value       = [for k, v in azurerm_iot_security_device_group.iot_security_device_groups : v.iothub_id]
}
output "iot_security_device_groups_name" {
  description = "List of name values across all iot_security_device_groups"
  value       = [for k, v in azurerm_iot_security_device_group.iot_security_device_groups : v.name]
}
output "iot_security_device_groups_range_rule" {
  description = "List of range_rule values across all iot_security_device_groups"
  value       = [for k, v in azurerm_iot_security_device_group.iot_security_device_groups : v.range_rule]
}

