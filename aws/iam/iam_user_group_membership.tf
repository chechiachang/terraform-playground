
resource "aws_iam_user_group_membership" "terraform-infra-admin" {
  user   = "terraform"
  groups = ["infra-admin"]

  depends_on = [
    aws_iam_user.terraform,
    aws_iam_group.infra-admin,
  ]
}

resource "aws_iam_user_group_membership" "chechia-infra-admin" {
  user   = "chechia-net"
  groups = ["infra-admin"]

  depends_on = [
    aws_iam_user.chechia-net,
    aws_iam_group.infra-admin,
  ]
}
