resource "helm_release" "aws_load_balancer_controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.9.2"
  timeout    = 300

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks.name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name = "vpcId"
    # value = data.terraform_remote_state.vpc.outputs.vpc_id
    value = "vpc-06d92c677740b17c7"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }

  depends_on = [
    aws_eks_node_group.general,
    aws_iam_role_policy_attachment.aws_load_balancer_controller_attach
  ]
}

resource "kubernetes_manifest" "flusk_app" {
  for_each = fileset("../../../k8s/", "*.y*ml")
  manifest = yamldecode(file("../../../k8s/${each.value}"))

  depends_on = [helm_release.aws_load_balancer_controller]
}