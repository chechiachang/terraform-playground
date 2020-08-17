
resource "aws_iam_user_group_membership" "my-user-my-group" {
  user   = "my-user"
  groups = ["my-group"]

  depends_on = [
    aws_iam_user.my-user,
    aws_iam_group.my-group,
  ]
}
