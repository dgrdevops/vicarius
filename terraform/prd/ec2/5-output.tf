output "ec2_devops_gha_runner_private_ip" {
  value       = aws_instance.gha_runner.private_ip
  description = "Private subnet CIDR block"
}

output "ecr_repo_arn" {
  value       = aws_ecr_repository.barkuni_repo.arn
  description = "ECR repo arn"
}