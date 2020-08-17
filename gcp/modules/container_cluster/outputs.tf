#data "google_container_cluster" "primary" {
#  name     = google_container_cluster.primary.name
#  location = google_container_cluster.primary.location
#}
#
#output "endpoint" {
#  value = data.google_container_cluster.primary.endpoint
#}
#
#output "instance_group_urls" {
#  value = data.google_container_cluster.primary.instance_group_urls
#}
#
#output "node_config" {
#  value = data.google_container_cluster.primary.node_config
#}
#
#output "node_pools" {
#  value = data.google_container_cluster.primary.node_pool
#}
#output "master_authorized_networks_config" {
#  value = data.google_container_cluster.primary.master_authorized_networks_config
#}
