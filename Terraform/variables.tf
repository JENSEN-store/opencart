variable "namespace" {
  type = string
  default = "opencart-tf"
}

variable "deploy_name" {
  type = string
  default = "tf-deploy"
}

variable "deploy_test_label" {
  type    = string
  default = "terraform-deploy-test-label"
}

variable "service_name" {
  type    = string
  default = "service-terraform"
}

variable "service_test_label" {
  type    = string
  default = "terraform-service-test-label"
}