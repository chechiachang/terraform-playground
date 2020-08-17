
resource "aws_instance" "my-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.my-instance.key_name

  tags = {
    Name = "my-instance"
  }

  depends_on = [
    aws_key_pair.my-instance
  ]
}
