provider "google" {
  credentials = file("/var/credential/terraform-general-credential.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
  version     = "~> 3.8"
}