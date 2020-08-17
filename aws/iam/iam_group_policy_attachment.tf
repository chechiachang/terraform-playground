
resource "aws_iam_group_policy_attachment" "infra-admin_AdministratorAccess" {
  group      = "infra-admin"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
