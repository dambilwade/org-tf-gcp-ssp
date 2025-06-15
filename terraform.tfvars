//The variable values defined in the root module

service_account = "service-account-1@eternal-argon-461501-a8.iam.gserviceaccount.com"
project_id = "eternal-argon-461501-a8"
region = "us-central1"
zone = "us-central1-a"

/* The instance map will be needed if we want to create resources by iterating over a list
The below values wont get used until enabled in main.tf

*/


instance_map = {
  "firstVM" = {
    instance_name_value = "firstobjectname"
  }
  "secondVM" = {
    instance_name_value = "secondobjectname"
  }
}
