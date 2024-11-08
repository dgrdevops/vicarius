resource "aws_ecr_repository" "barkuni_repo" {
  name                 = "${var.env}-barkuni-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_policy_document" "bakuni_doc" {
  statement {
    sid    = "IPAllow"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["058264138725"]
    }

    actions = [
      "ecr:*"
    ]

    condition {
      test = "IpAddress"
      variable = "aws:SourceIp"
      values = ["54.144.161.153/32"]
    }
  }
}

resource "aws_ecr_repository_policy" "barkuni_policy" {
  repository = aws_ecr_repository.barkuni_repo.name
  policy     = data.aws_iam_policy_document.bakuni_doc.json
}