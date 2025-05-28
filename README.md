# Self Service Developer Portal - Google Cloud Platform : Using Terraform
## Demo of Terraform declarative files to provision GCP resources

The script performs the following functions 
- [x] Provisions two e1-micro VMs in US East 1 Region
- [x] The VMs have 10G disk & default network routes + firewall Rules
- [x] Creates two storage bucket
- [x] Outputs the Assigned IPs & Bucket Names

## TODOs:

- [ ] Fine Grained access to provisioned resources
- [ ] Provide SSH access to the provisioned VM to any non GCP user having valid SSH keys
- [ ] CI-CD Integration
- [ ] Host the state file to cloud storage bucket


