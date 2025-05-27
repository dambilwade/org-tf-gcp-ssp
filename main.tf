terraform {
  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "gcp" {
  project = var.project_id
  region  = "us-east1"
  zone    = "us-east1-d"
}


resource "random_id" "rand_id" {
  byte_length = 8
}


resource "local_file" "default" {
  file_permission = "0644"
  filename        = "test-adk-agent/${random_id.rand_id.hex}-state-file.tf"

  # You can store the template in a file and use the templatefile function for
  # more modularity, if you prefer, instead of storing the template inline as
  # we do here.
  content = <<-EOT
  terraform {
    backend "gcs" {
      bucket = "test-adk-agent"
    }
  }
  EOT
}

module "compute" {
  
  for_each = var.instance_map
  source = "./compute"
  instance_name = each.value.instance_name_value
  service_account = var.service_account
  project_id = var.project_id


}

module "bucket" {

  for_each = var.instance_map
  source="./bucket"
  bucket_name = each.value.instance_name_value
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
  zone            = "us-east1-d"
  assignment_id   = "goog-ops-agent-v2-x86-template-1-4-0-us-east1-d"
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