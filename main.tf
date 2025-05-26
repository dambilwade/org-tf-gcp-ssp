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