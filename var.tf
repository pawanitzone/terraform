variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ubuntu-instance-username" {
  default = "ubuntu"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-0ee02acd56a52998e"
    ap-south-1 = "ami-0ee02acd56a52998e"
    eu-west-1 = "ami-0ee02acd56a52998e"
  }
}

variable "instance-type" {
  type = map
  default = {
    us-east-1 = "t3a.small"
  }
}

variable "ec2-public-key" {
  type = map
  default = {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzRPFEGwjBM//lMpcy/Apxz1CiwRmi9WDXGHSCZOiDzYaDgU9i58xZwTla94FbYgfo8H/zXKKuJy4q9gaGjhekZBVIYEfaZHdPqtOrhqrhxd28dSyC83xteV+vulpF35i3BRZh2Z542xEWokwdjVRhUeKwYZTnDeXD6wJFZOQSe0kYuzeNnbyHFI3zg6ZOs7DLAkjU3axtKYpQlajaPwbCw7LU2ZXCVkGkXunt7L77/Bilh9yqR3xwrF1zMPvaFvNXTFQdHB7dMK5SdlbXE4caPRJ5hU+g6PjajT3sJfQrlGWZhayFw6Fkcijb2svuEMNEOYu7iCeac/sZ01zlSgZ3bIl2Gm0rz4XpsevMrcPrwZnq4V7V9r0M4jAy+QHETOBCq4TmapvzJNGcoZ+yFV3LZe1Khtd04o0ODXnTro71TAQUY3z0CmCHZLpi0A7C6Uue6CCZ38lbPwT+8s5XNiWOg2gv3RmFa+Q1wfqPi6gosFdluBYxNiiwXEPF49e1YyE= pawkumar@C02CCEGSMD6M"
  }
}

variable "ubunut-ec2-private-key" {
  default = "/Users/pawkumar/.ssh/id_rsa"

}

/**
variable "k8s-vpc-public-subnet" {
  type = list
  default = ["172.168.1.0/24", "172.168.2.0/24", "172.168.3.0/24"]
}
variable "vpc_subnet_names" {
  type = list
  default = ["k8s-public-subnet-1a", "k8s-public-subnet-1b", "k8s-public-subnet-1c"]
}
variable "vpc_subnet_azs" {
  type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
**/