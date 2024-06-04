# variable "secret_1" {
#   description = "The first secret"
#   sensitive   = true
#   default     = ""
#   type        = string
#
# }
# variable "secret_2" {
#   description = "The second secret"
#   sensitive   = true
#   default     = ""
#   type        = string
# }
# locals {
#   secrets = {
#     secret_1 = var.secret_1
#     secret_2 = var.secret_2
#   }
# }
#
# variable "secret_obj1" {
#   type = object({
#     key   = string
#     value = sensitive(string)
#   })
# }
