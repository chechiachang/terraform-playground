
resource "aws_iam_user" "terraform" {
  force_destroy = "false"
  name          = "terraform"
  path          = "/"
}

resource "aws_iam_user" "chechia-net" {
  force_destroy = "false"
  name          = "chechia-net"
  path          = "/"
}
