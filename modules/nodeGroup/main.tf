# create EKS node group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = var.EKS_CLUSTER_ID
  node_group_name = "${var.EKS_CLUSTER_ID}-NodeGroup"
  node_role_arn = var.NODE_GROUP_ARN
  subnet_ids = [
    var.PRI_SUB3_ID,
    var.PRI_SUB4_ID
  ]
  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 2
  }
  ami_type = "AL2_x86_64" # Amazon Linux 2 (AL2) x86_64 bit version
  capacity_type = "ON_DEMAND"
  disk_size = 20
  force_update_version = false
  instance_types = ["t3.small"]
  labels = {
    role = "${var.EKS_CLUSTER_ID}-NodeGroupRole"
    name = "${var.EKS_CLUSTER_ID}-NodeGroup" 
  }
  version = "1.28"
}