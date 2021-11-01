data "google_compute_image" "image" {
  name    = "${var.image_name}"
  project = "${var.image_family}"
}

resource "google_compute_instance" "default" {
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
    subnetwork = google_compute_subnetwork.network_testing.name

    access_config {
      # nat_ip = "${google_compute_address.static.address}"
    }
  }

  service_account {
    email = "${var.service_account}"
    scopes = ["cloud-platform"]
  }

  #metadata_startup_script  = "${file("./start.sh")}"
}


resource "google_compute_subnetwork" "network_testing" {
  depends_on = [ google_compute_network.vpc_network_testing ]
  name = "terraform-subnetwork-testing"
  ip_cidr_range = "${var.ip_cidr_range}"
  region = "us-central1"
  network = google_compute_network.vpc_network_testing.name
}


#resource "google_compute_network" "vpc_network_testing" {
#    name                           = "terraform-network"
#    auto_create_subnetworks        = "false"  
#}

#output "ip" {
 # value = "${google_compute_instance.default.name.network_interface}"
  #value = each.key
#}