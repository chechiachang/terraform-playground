
resource "aws_iam_user" "my-user" {
  force_destroy = "false"
  name          = "my-user"
  path          = "/"
}
