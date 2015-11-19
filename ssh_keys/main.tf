variable "name" {}

resource "aws_key_pair" "mod" {
  key_name = "${var.name}"
  public_key = "${file("${path.module}/key.pub")}"
}

output "key_name"         { value = "${aws_key_pair.mod.key_name}" }
output "private_key_path" { value = "${path.module}/${var.name}.pem" }
output "public_key_path"  { value = "${path.module}/${var.name}.pub" }
