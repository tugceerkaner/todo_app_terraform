output "eks_cluster_arn" {
  value = aws_iam_role.iam_role_eks_cluster.arn
}

output "node_group_arn" {
  value = aws_iam_role.iam_role_node_group.arn
}