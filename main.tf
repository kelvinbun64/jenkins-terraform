data "google_compute_image" "image" {
  name    = "${var.image_name}"
  project = "${var.image_family}"
}

data "google_compute_network" "vpc_network"{
  name = "${var.network}"
  project = "${var.project}"
}

data "google_compute_subnetwork" "subnetwork"{
  name = "${var.subnetwork}"
  project = "${var.project}"
  region = "us-central1"

}

resource "google_compute_instance" "terraform-network" {
  for_each     = toset(var.instance_name)
  name         = each.value
  machine_type = "${var.machine_type}"
  tags         = "${var.tags}"
  zone         = "${var.region}"
  allow_stopping_for_update = true

  labels = {
    environment = "dev"
    #role = "mongodb"
  }

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.image.self_link}"
    }
  } 

  network_interface {
    #network = "${var.network}"
    network = "${data.google_compute_network.vpc_network.name}"
    #subnetwork = "${var.subnetwork}"
    subnetwork = "${data.google_compute_subnetwork.subnetwork.name}"

    #access_config {
      # nat_ip = "${google_compute_address.static.address}"
    #}
  }

 # resource "google_compute_network" "vpc_network" {
 #   name                           = "terraform-network"
  #  auto_create_subnetworks        = "false"  
#}

  service_account {
    email = "${var.service_account}"
    scopes = ["cloud-platform"]
  }

  #metadata_startup_script  = "${file("./start.sh")}"
}


 #resource "google_compute_subnetwork" "network_testing" {
  #depends_on = [ google_compute_network.vpc_network_testing ]
  #name = "terraform-subnetwork-testing"
  #p_cidr_range = "${var.ip_cidr_range}"
  #region = "us-central1"
  #network = google_compute_network.vpc_network_testing.name
#}


#output "ip" {
 # value = "${google_compute_instance.default.name.network_interface}"
  #value = each.key
#}