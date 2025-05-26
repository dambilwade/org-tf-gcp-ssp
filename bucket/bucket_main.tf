# Create new storage bucket in the US
# location with Standard Storage

resource "google_storage_bucket" bucket_name {
 name          = var.bucket_name
 location      = "us-east1"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true

 versioning {
    enabled = true
  }


website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
  }

  variable "bucket_name" {
    description = "Name of the bucket"
    type        = string
}

output "bucket_result" {
value =   google_storage_bucket.bucket_name.name
}