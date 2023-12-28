variable "checking_the_string" {
  type        = string
  description = "любая строка"
  default     = "I CAN right code"

  validation {
      condition = var.checking_the_string == lower(var.checking_the_string)
      error_message = "The string should not be uppercase"
  }
}


variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = true
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = var.in_the_end_there_can_be_only_one.Dunkan !=  var.in_the_end_there_can_be_only_one.Connor
    }
}
