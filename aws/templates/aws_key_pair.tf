
resource "aws_key_pair" "my-instance" {
  key_name   = "my-instance"
  public_key = "my-public-key"
}
