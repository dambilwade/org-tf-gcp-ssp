terraform {

  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  

  //Enable the below block if the state file needs to be on GCP Bucket
  /*
  backend "gcs" {
    bucket = "staging_bucket_ai"
    prefix = "terraform/state"
  }*/
}

provider "gcp" {
  project = var.project_id
  region  = var.region
  zone    = var.zone

}

provider "tls" {}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
  }

resource "local_file" "ssh_private_key_pem" {
  content      = tls_private_key.ssh.private_key_pem
  filename     = "${random_id.rand_id_1.hex}-ssh_private_key.pem"
  file_permission = "0600"
}

resource "random_id" "rand_id_1" {
  byte_length = 4
}

module "compute" {
  
  #for_each = var.instance_map
  source = "./compute"
  instance_name = "vm${random_id.rand_id_1.hex}"
  #instance_name = "each.value.instance_name_value"
  service_account = var.service_account
  project_id = var.project_id
  region = var.region
  zone = var.zone
  username = "${random_id.rand_id_1.hex}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}
/*
The for_each & instance_name statements in compute and bucket module would be required 
if we want to create a numerous resources by iterating over a list
*/

module "bucket" {

  #for_each = var.instance_map
  source="./bucket"
  bucket_name = "bk${random_id.rand_id_1.hex}"
  #bucket_name = "each.value.instance_name_value"
  region = var.region
}

  
  output "ComputeAll" {
    value = module.compute
  }

  output "BucketAll" {
    value = module.bucket
  }


module "ops_agent_policy" {
  source          = "github.com/terraform-google-modules/terraform-google-cloud-operations/modules/ops-agent-policy"
  project         = var.project_id
  zone            = var.zone
  
  assignment_id   = "goog-ops-agent-v2-x86-template-1-4-0-${var.zone}"
  agents_rule = {
    package_state = "installed"
    version = "latest"
  }
  instance_filter = {
    all = false
    inclusion_labels = [{
      labels = {
        goog-ops-agent-policy = "v2-x86-template-1-4-0"
      }
    }]
  }
}

