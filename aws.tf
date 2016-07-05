variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

// Ubuntu 15.04 LTS official hvm:ebs volumes to their region.
variable "aws_amis" {
  default = {
    ap-northeast-1 = "ami-190e3477"
    ap-southeast-1 = "ami-ec7ab58f"
    eu-central-1 = "ami-c59189a9"
    eu-west-1 = "ami-9f388eec"
    sa-east-1 = "ami-ff1f9f93"
    us-east-1 = "ami-370c225d"
    us-west-1 = "ami-4e1a6c2e"
    cn-north-1 = "ami-fd79b090"
    ap-southeast-2 = "ami-f6b79395"
    us-west-2 = "ami-2f06e04f"
  }
}

resource "aws_vpc" "terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags { Name = "terraform" }
}

resource "aws_internet_gateway" "terraform" {
  vpc_id = "${aws_vpc.terraform.id}"
  tags { Name = "terraform" }
}

resource "aws_subnet" "terraform" {
  vpc_id = "${aws_vpc.terraform.id}"
  cidr_block = "10.0.0.0/24"
  tags { Name = "terraform" }
  availability_zone = "eu-west-1b"

  map_public_ip_on_launch = true
}

resource "aws_route_table" "terraform" {
  vpc_id = "${aws_vpc.terraform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform.id}"
  }

  tags { Name = "terraform" }
}

// The Route Table Association binds our subnet and route together.
resource "aws_route_table_association" "terraform" {
  subnet_id = "${aws_subnet.terraform.id}"
  route_table_id = "${aws_route_table.terraform.id}"
}

// The AWS Security Group is akin to a firewall. It specifies the inbound
// only open required ports in a production environment.
resource "aws_security_group" "terraform" {
  name   = "terraform-web"
  vpc_id = "${aws_vpc.terraform.id}"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
