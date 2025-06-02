output "cluster_name" {
  value = google_container_cluster.primary_cluster.name
}

output "kubernetes_endpoint" {
  value = google_container_cluster.primary_cluster.endpoint
}

output "region" {
  value = var.region
}
