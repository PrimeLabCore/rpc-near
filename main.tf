
resource "aws_key_pair" "mainnet" {
  key_name = "mainnet"
  public_key = "${file("id_rsa.pub")}"
}

# Mainnet EC2
resource "aws_instance" "mainnet" {
  # ami               = "${data.aws_ami.ubuntu.id}"
  ami                 = "ami-05601538be05d3a61"
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = "${aws_key_pair.mainnet.key_name}"

  tags = {
    name: "mainnet"
    env:  "mainnet"
  }
}
