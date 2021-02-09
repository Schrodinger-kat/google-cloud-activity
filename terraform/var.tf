variable "region" {
  type = string
}
variable "gcp_project_id" {
  type = string
}
variable "name" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "subnet_cidr" {

}
variable "fw_name" {
  type = string
}
variable "route_name" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "dest_range" {
  type = string
}
variable "next_hop_ip" {
  type = string
}
variable "inst_type"{
  type = string
  description = "f1-micro"
}