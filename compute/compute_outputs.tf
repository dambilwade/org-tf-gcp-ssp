output "Result_1_ID" {
value =   google_compute_instance.instance_name.id
}

output "Result_2_hostname" {
value =   google_compute_instance.instance_name.name
}

output "Result_3_Network_IP_INT" {
value =   google_compute_instance.instance_name.network_interface.0.network_ip
}

output "Result_4_Network_IP_EXT" {
value =   google_compute_instance.instance_name.network_interface.0.access_config.0.nat_ip
}

output "Result_5_UserName" {
value =   "${var.username}"
}

output "Result_6_ConnectionString" {
value =   "ssh -i ${var.username}-ssh_private_key.pem ${var.username}@${google_compute_instance.instance_name.network_interface.0.access_config.0.nat_ip}"
}