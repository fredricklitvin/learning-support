output "ansible_public_ip" {
  value = google_compute_instance.ansible.network_interface[0].access_config[0].nat_ip
}

output "app_private_ip" {
  value = google_compute_instance.app.network_interface[0].network_ip
}

output "net_private_ip" {
  value = google_compute_instance.net.network_interface[0].network_ip
}
