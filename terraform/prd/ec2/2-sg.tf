# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "prd-aws-tf-state-backend"
#     key    = "terraform/prd/networking/vpc/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

resource "aws_security_group" "gha_sg" {
  name        = "${var.env}-${var.application}-sg"
  description = "${var.env}-${var.application}-sg"
  # vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_id = "vpc-06d92c677740b17c7"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}