variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "intra_subnet_ids" { type = list(string) }
variable "eks_cluster_sg_id" { type = string }

variable "db_password" {
  description = "Common master password for all DBs (should be injected via secret)"
  type        = string
  sensitive   = true
}
