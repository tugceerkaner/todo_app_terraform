# create IAM role for EKS cluster
resource "aws_iam_role" "iam_role_eks_cluster" {
  name = "${var.PROJECT_NAME}-EKSRole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# attach AmazonEKSClusterPolicy to the EKS role
resource "aws_iam_role_policy_attachment" "iam_role_eks_cluster_policy" {
  # amazon resource name = arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.iam_role_eks_cluster.name
}

# attach ElasticLoadBalancingFullAccess policy to the EKS role
resource "aws_iam_role_policy_attachment" "iam_role_elb_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  role = aws_iam_role.iam_role_eks_cluster.name
}

# create IAM role for EKS node group
resource "aws_iam_role" "iam_role_node_group" {
  name = "${var.PROJECT_NAME}-NodeGroupRole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# attach AmazonEKSWorkerNodePolicy to the worker node role
resource "aws_iam_role_policy_attachment" "iam_role_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.iam_role_node_group.name
}

# attach AmazonEKS_CNI_Policy to the EKS node group role
resource "aws_iam_role_policy_attachment" "iam_role_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.iam_role_node_group.name
}

# attach AmazonEC2ContainerRegistryReadOnly policy to the EKS node group role
resource "aws_iam_role_policy_attachment" "iam_role_ecr_readOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.iam_role_node_group.name
}