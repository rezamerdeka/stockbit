variable "product" {}
variable "environment" {}
variable "ami" {}
variable "type" {}
variable "zone" {}
variable "subnet" {}
variable "vpcid" {}
variable "bucket_name" {}
variable "acl_value" {}

variable "force_destroy" {
  description = "bye"
  type        = string
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket"
  type        = "map"
  default     = {"env": "test"}
}
