#https://stackoverflow.com/questions/5284147/validating-ipv4-addresses-with-regexp
variable "ip_address" {
  description = "ip-адрес"
  type        = string
  default = "1920.1680.0.1"
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ip_address))
    error_message = "Invalid ip address is specified."
  }
}

variable "list_of_ip_addresses" {
  description = "список ip-адресов"
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  validation {
    condition = alltrue([for ip_address in var.list_of_ip_addresses: can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip_address))])
    error_message = "The IP address list is incorrect."
  }
}