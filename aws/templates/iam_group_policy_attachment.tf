
resource "aws_iam_group_policy_attachment" "my-group_my-policy" {
  group      = "my-group"
  policy_arn = "arn:aws:iam::aws:policy/my-policy"

  depends_on = [
    aws_iam_group.my-group,
  ]
}
