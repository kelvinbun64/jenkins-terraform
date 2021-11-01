variable "instance_name" {
  type = list(string)
  default = []
}

variable "machine_type" {
  description = "specified image id for instance"
  default = "n1-standard-1"
}

variable "region" {
  description = "gcp region for specified instance"
  default = "us-central1-c"
}

variable "project" {
  description = "project name in which we will create all instance"
  default = "angelic-cat-328204"
}

variable "image_name" {
  description = "image type for given instance"
  default = "ubuntu-1604-xenial-v20190411"
}

variable "image_family" {
  description = "image family for given instance"
  default = "ubuntu-os-cloud"
}

variable "network" {
  description = "network for given instance"
  default = "default"
}

variable "ip_cidr_range" {
  description = "network ip cidr"
  default = "10.1.0.0/16"
}

variable "credential" {
  description = "credential file path different for different users"
  default = "angelic-cat-328204-e117a3630a1b.json"
}

variable "tags" {
  type = list(string)
  description = "tags is used for defining the rule of a instance"
}

variable "service_account" {
  default = "96353178674-compute@developer.gserviceaccount.com"
}
