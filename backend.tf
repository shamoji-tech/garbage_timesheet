terraform {
  required_version = ">= 0.12.26"

  backend "gcs" {
    bucket = "terraform-backend123"
    prefix = "terraform/garbage-state"
    credentials = "/var/credential/terraform-general-credential.json"
  }
  
}
