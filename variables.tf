variable "project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "region" {
  type        = string
  default     = "europe-west1"
  description = "GCP region"
}
