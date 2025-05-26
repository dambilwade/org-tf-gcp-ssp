# tf-gcp-ssp
Demo of Terraform declarative files to provision GCP resources

The script performs the following functions 
Provisions two e1-micro VMs in US East 1 Region
The VMs have 10G disk & default network routes + firewall Rules
Creates two Bucket
Outputs the Assigned IPs & Bucket Names

TODOs:
Fine Grained access to provisioned resources
Provide SSH access to the provisioned VM to any non GCP user having valid SSH keys
CI-CD Integration
Resources to be created in a new GCP project each time the TF scripts are triggered - This is manadatory if the scripts are intended to be used for a Developer Portal for Self Service Provisioning
Management Project & Management Users - Needed if the script is intended to be used for Developer Portal - Self Service Provisioning


