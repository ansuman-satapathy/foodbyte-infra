resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-${var.environment}-node-group"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = var.private_subnet_ids

  instance_types = ["t4g.small"]
  ami_type       = "AL2023_ARM_64_STANDARD"
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ecr_read_only,
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-node"
  }
}
