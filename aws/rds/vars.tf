variable "db_availability_zone" {
  type        = string
  description = "Availabilty zone to provision mysql db in."
}

variable "username" {
  description = "mysql db username"
}

variable "password" {
  description = "mysql db password"
}

variable "region" {
  default = "us-west-2"
}