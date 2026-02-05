variable "project_id" {
    default = "brave-inn-477912-q1"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-a"
}
variable "ssh_user" {
  default = "fred"
}
variable "ssh_pub_key" {
    default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFvOI/u+57jyFTNV1hXsW3eWjJCSvBAcJTRNdOKsrZdT ansible-lab"
}
variable "terraform_state_bucket" {
  default = "terraform-support-backend"
}